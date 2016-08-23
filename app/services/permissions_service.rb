class PermissionsService
  attr_reader :user
  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = _controller
    @action = _action
    return platform_admin_permissions(controller, action) if user.platform_admin?
    return business_admin_permissions(controller, action) if user.business_admin?
    return registered_user_permissions(controller, action) if user.registered_user?
    return visitor_permissions(controller, action)
  end

  private
  def controller
    @controller
  end

  def action
    @action
  end

  def platform_admin_permissions
    return true if controller == 'businesses' && action.in?(["show", ])
    return true if controller == 'business_admins'
    return true if controller == 'cart_items'
    return true if controller == 'cart'
    return true if controller == 'categories'
    return true if controller == 'errors'
    return true if controller == 'items'
    return true if controller == 'orders'
    return true if controller == 'sessions'
    return true if controller == 'users'
  end

  def business_admin_permissions
    return true if controller == 'businesses'
    return true if controller == 'business_admins'
    return true if controller == 'cart_items'
    return true if controller == 'cart'
    return true if controller == 'categories'
    return true if controller == 'errors'
    return true if controller == 'items'
    return true if controller == 'orders'
    return true if controller == 'sessions'
    return true if controller == 'users'
  end

  def registered_user_permissions
    return true if controller == 'businesses'
    return true if controller == 'cart_items'
    return true if controller == 'cart'
    return true if controller == 'categories'
    return true if controller == 'errors'
    return true if controller == 'items'
    return true if controller == 'orders'
    return true if controller == 'sessions'
    return true if controller == 'users'
  end

  def visitor_permissions
    return true if controller == 'businesses'
    return true if controller == 'cart_items'
    return true if controller == 'cart'
    return true if controller == 'categories'
    return true if controller == 'errors'
    return true if controller == 'items'
    return true if controller == 'sessions'
    return true if controller == 'users'
  end
end
