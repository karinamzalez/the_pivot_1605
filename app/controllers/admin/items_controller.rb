class Admin::ItemsController < ApplicationController
  def edit
    @item = Item.find_by(slug: params[:id])
  end
end
