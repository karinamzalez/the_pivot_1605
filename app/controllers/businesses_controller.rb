class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
    @categories = Category.all
  end

  def show
    @business = Business.find_by(slug: params[:business_slug])
  end

  def edit
    @business = Business.find(target_business)
  end

  def update
    business = Business.find(target_business)
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
    params.require(:business).permit(:name, :location)
  end
  
  def target_business
    if current_user.business_admin?
      Business.find(current_user.business)
    else 
      Business.find(params[:id])
    end
  end
end
