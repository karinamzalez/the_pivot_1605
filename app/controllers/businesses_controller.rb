class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
    @categories = Category.all
  end

  def new
    @business = Business.new
  end

  def create
    # @business = Business.new(business_params)
    # if @business.save
    #   flash[:notice] = 'Thank you for applying to Worldwide Farmers Market! We will let you know if you have been approved shortly.'
    #   redirect_to dashboard_path
  end

  def show
    @business = Business.find_by(slug: params[:business_slug])
  end

  def edit
    @business = Business.find(current_user.business_id)
  end

  def update
    business = Business .find(current_user.business_id)
    if business.update(business_params)
      redirect_to dashboard_path
      flash[:notice] = 'Business information updated successfully!'
    else
      flash[:danger] = 'Business information not updated successfully.'
      redirect_to edit_business_path(business)
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :location, :status)
  end
end
