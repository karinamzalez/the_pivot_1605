class BusinessAdminsController < ApplicationController

  def new
  end

  def create
    @business = current_user.business
    business_admin = User.find_by(email: params[:email])
    business_admin.set_business_admin(@business)
    redirect_to edit_business_admin_path(@business.id)
  end

  def edit
    @business_admins = User.where(business_id: current_user.business_id)
  end
end
