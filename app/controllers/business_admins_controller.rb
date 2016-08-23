class BusinessAdminsController < ApplicationController

  def new
    @business = Business.find(params[:id])
  end

  def create
    @business = target_business
    business_admin = User.find_by(email: params[:email])
    business_admin.set_business_admin(@business)
    redirect_to edit_business_admin_path(@business)
  end

  def edit
    @business_admins = User.where(business_id: target_business)
  end
  
  def destroy
    @business = target_business
    removed_admin = User.find_by(username: params[:removed_admin])
    removed_admin.remove_business_admin
    redirect_to edit_business_admin_path(@business)
  end
  
  private
  
  def target_business
    target_business = current_user.business || Business.find(params[:id])
  end
end
