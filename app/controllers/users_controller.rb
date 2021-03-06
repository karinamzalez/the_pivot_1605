class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
    if @user.business_admin?
      @business = Business.find(@user.business_id)
    elsif @user.platform_admin?
      @businesses = Business.all
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      registered_role = Role.find_by(name: "registered_user") || nil
      @user.roles << registered_role
      @user.save
      session[:user_id] = @user.id
      redirect_to check_cart
    else
      flash[:danger] = "Account creation failed. Please try again."
      render :new
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to dashboard_path
      flash[:notice] = 'Account information updated successfully!'
    else
      redirect_to edit_user_path(@user)
      flash[:notice] = 'Account information update failed. Please try again.'
    end
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :role)
  end
end
