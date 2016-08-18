class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
    @categories = Category.all
  end

  def show
    @business = Business.find_by(slug: params[:slug])
  end
end
