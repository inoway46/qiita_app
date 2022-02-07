class ItemsController < ApplicationController
  
  def index
    @q = Item.ransack(params[:q])
    @items = @q.result.page(params[:page])
  end
end
