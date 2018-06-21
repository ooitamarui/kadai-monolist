class ItemsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @items = []

    @keyword = params[:keyword]
    if @keyword.present? # 
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        # 扱い易いように Item としてインスタンスを作成する（保存はしない）
        item = Item.new(read(result))
        @items << item
      end
    end
  end

  private

  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    #gsub は文字列置換用のメソッドで、第一引数を見つけ出して、第二引数に置換するメソッド
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end