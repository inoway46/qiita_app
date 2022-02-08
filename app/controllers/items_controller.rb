class ItemsController < ApplicationController
  
  def index
    @q = Item.includes(:user, :tags).ransack(params[:q])
    @items = @q.result.page(params[:page])
  end
end
