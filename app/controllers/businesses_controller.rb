class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
    @categories = Category.all
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
      render edit_business_path
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :location)
  end
end
