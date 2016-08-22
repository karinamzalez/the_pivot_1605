class BusinessAdminsController < ApplicationController
  def edit
    @business_admins = User.where(business_id: current_user.business_id)
    require "pry"; binding.pry
  end
end
