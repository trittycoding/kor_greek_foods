class AddCustomerProvinceRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :customer_province, null: false, foreign_key: true
  end
end
