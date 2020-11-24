class RenameCustomerProvinceToProvinces < ActiveRecord::Migration[6.0]
  def change
    rename_table :customer_provinces, :provinces
  end
end
