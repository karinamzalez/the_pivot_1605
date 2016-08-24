class SessionsController < ApplicationController
  def new
  end

  def create
    @user = find_user || nil
    authenticate_user
  end

  def destroy
    session.clear
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

  private

  def find_user
    if request.env['omniauth.auth']
      user = User.find_by(username: request.env['omniauth.auth']['info']['nickname'])
    else
      user = User.find_by(username: params[:session][:username])
    end
  end

  def authenticate_user
    if params[:session]
      authenticate_with_password
    else
      authenticate_with_twitter
    end
  end

  def authenticate_with_password
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect_to check_cart
    else
      invalid_login
    end
  end

  def authenticate_with_twitter
    if @user && request.env['omniauth.auth']['info']
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in using Twitter!"
      redirect_to check_cart
    else
      invalid_login
    end
  end

  def invalid_login
    flash[:danger] = "Invalid login!"
    render :new
  end
end
