class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :time_format
  before_action :populate_nav, :set_cart, :authorize!

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def time_format(raw_time)
    raw_time.strftime("%b %e, %l:%M %p")
  end

  def populate_nav
    @categories = Category.all unless Category.all.empty?
    @businesses = Business.all unless Business.all.empty?
  end

  def check_cart
    if session[:cart]
      return cart_path
    else
      dashboard_path
    end
  end

  private

  def authorize!
    redirect_to(root_url, danger: "You are not authorized.") unless authorized?
  end

  def authorized?
    current_permission.allow?
  end

  def current_permission
    @current_permission ||= PermissionsService.new(current_user, params[:controller], params[:action])
  end
end
