class UsersController < ApplicationController
  # before_action :require_current_user, only: [:show, :update]
  def new
    @user = User.new
  end

  def show
    @user = current_user
    @business = Business.find(@user.business_id) if @user.business_id
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:danger] = "Account creation failed. Please try again."
      render :new
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to dashboard_path
      flash[:notice] = 'yes'
    else
      redirect_to edit_user_path(@user)
      flash[:notice] = 'no'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :role)
  end
end
