class ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(20)
  end
end
