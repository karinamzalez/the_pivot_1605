class Category < ActiveRecord::Base
  has_many :items

  validates_uniqueness_of :name

  def to_param
    self.name.parameterize
  end

  def self.find_by_name(params_id)
    where('lower(name) = ?', deparameterize(params_id)).first
  end

  def self.deparameterize(params_id)
    params_id.tr("-", " ")
  end
end
