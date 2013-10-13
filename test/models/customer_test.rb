require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = customers(:smith)
  end

  def test_full_name
    assert_equal "John Smith", @customer.full_name
  end

  def test_full_name_only_last
    assert_equal "Jones", customers(:jones).full_name
  end

  def test_not_anonymous
    assert !@customer.anonymous?
  end

  def test_anonymous
    @customer.first_name = ''
    @customer.last_name = ''
    assert @customer.anonymous?
  end
end
