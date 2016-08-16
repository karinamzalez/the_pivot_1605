class UsersController < ApplicationController
  before_action :require_current_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def show
    @top_three_orders = current_user.orders.first(3) unless current_user.orders.empty?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:danger] = "Account creation failed. Try again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :country_code, :phone_number, :role)
  end

  def require_current_user
    render file: "/public/404" unless current_user?
  end

  def current_user?
    current_user && current_user.default?
  end
end
