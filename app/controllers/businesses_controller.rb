class BusinessesController < ApplicationController

  def index
    @categories = Category.all unless Category.all.empty?
    @businesses = Business.all unless Business.all.empty?
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      current_user.update_attribute(:business_id, @business.id)
      flash[:notice] = 'Thank you for applying to Worldwide Farmers Market! We will let you know if you have been approved shortly.'
      redirect_to dashboard_path
    else
      flash[:danger] = 'You must fill out all fields.'
      redirect_to new_business_path
    end
  end

  def show
    @business = Business.find_by(slug: params[:business_slug])
  end

  def edit
    @business = Business.find(target_business.id)
  end

  def update
    business = Business.find(target_business.id)
    User.find_by(business_id: business.id).roles << Role.find_by(name: "business_admin") if params[:business][:add_business_admin]
    if business.update(business_params)
      flash[:notice] = 'Business information updated successfully!'
      redirect_to dashboard_path
    else
      flash[:danger] = 'Business information not updated successfully.'
      redirect_to edit_business_path(business)
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    flash[:notice] = "#{@business.name} declined."
    redirect_to dashboard_path
  end

  private

  def business_params
    params.require(:business).permit(:name, :location, :status)
  end

  def target_business
    target_business = current_user.business || Business.find(params[:id])
  end
end
