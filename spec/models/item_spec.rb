require 'rails_helper'

include TestHelper

describe Item, type: :model do
  it "removes business association" do
    business = create(:business)
    item = create(:item)
    business.items << item

    (item.status).should eq(true)

    item.deactivate_item

    (item.status).should eq(false)
  end
end
