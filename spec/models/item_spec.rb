require 'rails_helper'

include TestHelper

describe Item, type: :model do
  it "removes business association" do
    business = create(:business)
    item = create(:item)
    business.items << item

    item.remove_business

    (item.businesses).should eq("")
  end
end
