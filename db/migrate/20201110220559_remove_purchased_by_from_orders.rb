class RemovePurchasedByFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :purchasedby, :integer
  end
end
