class RemoveUsersIdFromCustomerProvinces < ActiveRecord::Migration[6.0]
  def change
    remove_column :customer_provinces, :users_id, :integer
  end
end
