class ToppagesController < ApplicationController
#商品を Want すると、Item を保存します。このとき、保存した Item を トップページにも表示する
  def index
    @items = Item.order('updated_at DESC')
  end
end
