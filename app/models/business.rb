class Business < ActiveRecord::Base
  before_create :create_slug
  belongs_to :user

  def create_slug
    self.slug = self.name.parameterize
  end
end
