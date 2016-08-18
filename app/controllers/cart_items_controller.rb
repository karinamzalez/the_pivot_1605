class CartItemsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :fetch_item, :only => [:update, :destroy]

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item)
    session[:cart] = @cart.contents
    flash[:success] = "Added #{pluralize(@cart.contents[item.id.to_s], item.name)} to your cart."
    redirect_to item_path(item)
  end

  def update
    cart_item = CartItem.new(@item.id)
    cart_item.adjust_quantity(params[:adjustment], @cart)
    redirect_to cart_path
  end

  def destroy
    @cart.contents.delete(params[:id])
    flash[:success] = %Q[Successfully removed <a href="/items/#{@item.id}">#{@item.name}</a>]
    redirect_to cart_path
  end

  private

  def fetch_item
    @item = Item.find(params[:id])
  end
end
