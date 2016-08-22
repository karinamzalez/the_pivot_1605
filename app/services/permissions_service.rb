class PermissionsService
  attr_reader :user
  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller)
    return platform_admin_permissions(controller) if user.platform.admin?
    return business_admin_permissions(controller) if user.business_admin?
    return registered_user_permissions(controller)
  end

  private

  def platform_admin_permissions(controller)
  end

  def business_admin_permissions(controller)
    return true if controller = 'businesses'
    return true if controller = 'items'
    return true if controller = 'orders'
    return true if controller = 'session'
  end

  def registered_user_permissions(controller)
  end
end
