require 'spec_helper'

describe Customer do
  let(:customer){ FactoryGirl.create(:customer) }
  let(:customer_jones){ FactoryGirl.create(:customer, first_name: nil, last_name: "Jones") }

  describe "#full_name" do
    it "should join together the first and last names" do
      expect(customer.full_name).to eq("John Smith")
    end

    it "should only output the names if they are present" do
      expect(customer_jones.full_name).to eq("Jones")
    end
  end

  describe "#anonymous?" do
    it "should be false if the customer has a #full_name" do
      expect(customer).to_not be_anonymous
    end

    it "should be true if the customer does not have a #full_name" do
      expect(customer).to receive(:full_name).and_return('')
      expect(customer).to be_anonymous
    end
  end

  describe "#phone" do
    let(:customer){ FactoryGirl.build(:customer, phone_number: "2222222", phone_area_code: "204")}

    it "should combine the phone number and area code with formatting" do
      expect(customer.phone).to eq("(204) 222-2222")
    end

    it "should skip the area code" do
      customer.phone_area_code = ''
      expect(customer.phone).to eq("222-2222")
    end

    it "should not display anything if the phone number is not present" do
      customer.phone_number = ''
      expect(customer.phone).to be_nil
    end
  end

end
