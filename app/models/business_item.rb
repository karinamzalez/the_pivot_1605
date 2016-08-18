class BusinessItem < ActiveRecord::Base
  belongs_to :business
  belongs_to :item
end