class PermissionsService
<<<<<<< HEAD

  def initialize(user, controller, action)
    @_user       = user || User.new
    @_controller = controller
    @_action     = action
=======
  attr_reader :user
  def initialize(user, _controller, _action)
    @user = user || User.new
    @controller = _controller
    @action = _action
>>>>>>> c45298dde75edcebffac8e6610812bb4ef8502b8
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

<<<<<<< HEAD
  def user
    @_user
  end

  def controller
    @_controller
  end

  def action
    @_action
  end

  def platform_admin_permissions(controller)
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

  def business_admin_permissions(controller)
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
    return true if controller == 'admin/items' && action.in?(%w(edit update destroy create new))
=======
  def platform_admin_permissions
    return true if controller == 'businesses' && action.in?(%w(index show new create edit update))
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
>>>>>>> c45298dde75edcebffac8e6610812bb4ef8502b8
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
