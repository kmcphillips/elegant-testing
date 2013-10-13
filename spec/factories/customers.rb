FactoryGirl.define do
  factory :customer do
    first_name "John"
    last_name "Smith"
    phone_number "1234567"
    phone_area_code "123"
    sequence(:email){|number| "customer_#{ number }@example.com"}
  end
end
