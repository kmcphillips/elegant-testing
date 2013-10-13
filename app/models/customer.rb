class Customer < ActiveRecord::Base

  validates :phone_number, :fax_number, format: {with: /\A[0-9]{7}\Z/, allow_blank: true}
  validates :phone_area_code, :fax_area_code, format: {with: /\A[0-9]{3}\Z/, allow_blank: true}

  def anonymous?
    full_name.blank?
  end

  def full_name
    [first_name, last_name].reject(&:blank?).join(" ")
  end

end
