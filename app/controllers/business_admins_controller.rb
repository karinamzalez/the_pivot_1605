class BusinessAdminsController < ApplicationController
  def edit
    @business_admins = User.where(businesses_id: current_user.businesses_id)
  end
end
