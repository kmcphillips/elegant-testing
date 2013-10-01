require 'spec_helper'

describe Customer do
  let(:customer){ FactoryGirl.create(:customer) }
  let(:customer_jones){ FactoryGirl.create(:customer, first_name: nil, last_name: "Jones") }

  describe "#full_name" do
    it "should join the first and last name" do
      expect(customer.full_name).to eq("John Smith")
    end

    it "should only show the names present" do
      expect(customer_jones.full_name).to eq("Jones")
    end
  end

  describe "#anonymous?" do
    it "should not be anonymous if it has a #full_name" do
      expect(customer).to_not be_anonymous
    end
  end

end
