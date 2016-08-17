class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
    @categories = Category.all
  end

  def show
    @business = Business.find(params[:id])
  end
end
