class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
    @categories = Category.all
  end

  def show
    @business = Business.find_by(slug: params[:business_slug])
  end
end
