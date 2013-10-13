class AddPhoneNumbersToCusomter < ActiveRecord::Migration
  def change
    add_column :customers, :phone_number, :string
    add_column :customers, :phone_area_code, :string
    add_column :customers, :fax_number, :string
    add_column :customers, :fax_area_code, :string
  end
end
