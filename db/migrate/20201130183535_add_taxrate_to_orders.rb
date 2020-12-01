class AddTaxrateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :taxrate, :decimal
  end
end
