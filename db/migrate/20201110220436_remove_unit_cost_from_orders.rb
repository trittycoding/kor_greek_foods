class RemoveUnitCostFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :unitcost, :decimal
  end
end
