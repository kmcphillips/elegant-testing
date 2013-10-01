class Customer < ActiveRecord::Base

  def anonymous?
    full_name.blank?
  end

  def full_name
    [first_name, last_name].reject(&:blank?).join(" ")
  end

end
