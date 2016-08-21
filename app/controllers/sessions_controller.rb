class SessionsController < ApplicationController
  helper_method :user_admin_redirect
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
      redirect_to check_cart
    else
      flash[:danger] = "Invalid login!"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

  private

  def check_cart
    if session[:cart]
      return cart_path
    else
      dashboard_path
    end
  end
end
