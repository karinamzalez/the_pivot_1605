class BusinessAdminsController < ApplicationController

  def new
  end

  def create
    @business = current_user.business
    business_admin = User.find_by(email: params[:email])
    business_admin.set_business_admin(@business)
    redirect_to edit_business_admin_path(@business)
  end

  def edit
    target_business = current_user.business_id || params[:id]
    @business_admins = User.where(business_id: target_business)
  end
  
  def destroy
    @business = current_user.business
    removed_admin = User.find_by(username: params[:removed_admin])
    removed_admin.remove_business_admin
    redirect_to edit_business_admin_path(@business)
  end
end
