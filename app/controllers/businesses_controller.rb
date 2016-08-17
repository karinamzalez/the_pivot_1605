class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
    @categories = @businesses.items.categories
  end

  def show
  end
end
