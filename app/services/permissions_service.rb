class PermissionsService
  attr_reader :user
  def initialize(user, _controller, _action)
    @user = user || User.new
    @controller = _controller
    @action = _action
  end

  def allow?
    return platform_admin_permissions if user.platform_admin?
    return business_admin_permissions if user.business_admin?
    return registered_user_permissions if user.registered_user?
    return visitor_permissions
  end

  private
  def controller
    @controller
  end

  def action
    @action
  end

  def platform_admin_permissions
    return true if controller == 'businesses' && action.in?(%w(index show new create edit update destroy))
    return true if controller == 'business_admins' && action.in?(%w(new create edit update))
    return true if controller == 'cart_items' && action.in?(%w(create update destroy))
    return true if controller == 'cart' && action.in?(%w(show update))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'errors' && action.in?(%w(not_found))
    return true if controller == 'items' && action.in?(%w(index show new create edit update destroy))
    return true if controller == 'orders' && action.in?(%w(index show create))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show new create edit update))
  end

  def business_admin_permissions
    return true if controller == 'businesses' && action.in?(%w(index show new create edit update))
    return true if controller == 'business_admins' && action.in?(%w(new create edit update))
    return true if controller == 'cart_items' && action.in?(%w(create update destroy))
    return true if controller == 'cart' && action.in?(%w(show update))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'errors' && action.in?(%w(not_found))
    return true if controller == 'items' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(index show create))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show new create edit update))
  end

  def registered_user_permissions
    return true if controller == 'businesses' && action.in?(%w(index show new create))
    return true if controller == 'cart_items' && action.in?(%w(create update destroy))
    return true if controller == 'cart' && action.in?(%w(show update))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'errors' && action.in?(%w(not_found))
    return true if controller == 'items' && action.in?(%w(index show))
    return true if controller == 'orders' && action.in?(%w(index show create))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show new create edit update))
  end

  def visitor_permissions
    return true if controller == 'businesses' && action.in?(%w(index show))
    return true if controller == 'cart_items' && action.in?(%w(create update destroy))
    return true if controller == 'cart' && action.in?(%w(show update))
    return true if controller == 'categories' && action.in?(%w(show))
    return true if controller == 'errors' && action.in?(%w(not_found))
    return true if controller == 'items' && action.in?(%w(index show))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'users' && action.in?(%w(show new create edit update))
  end
end
