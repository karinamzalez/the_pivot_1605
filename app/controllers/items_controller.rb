class ItemsController < ApplicationController
  def show
    @item = Item.find_by(slug: params[:id])
  end
end
