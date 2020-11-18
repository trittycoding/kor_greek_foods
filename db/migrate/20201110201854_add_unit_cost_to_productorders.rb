class AddUnitCostToProductorders < ActiveRecord::Migration[6.0]
  def change
    add_column :productorders, :unitcost, :decimal
  end
end
