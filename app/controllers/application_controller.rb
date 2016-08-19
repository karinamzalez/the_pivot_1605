class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :time_format, :current_admin?
  before_action :populate_nav, :set_cart

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def time_format(raw_time)
    raw_time.strftime("%b %e, %l:%M %p")
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def populate_nav
    @categories = Category.all unless Category.all.empty?
    @businesses = Business.all unless Business.all.empty?
  end
end
