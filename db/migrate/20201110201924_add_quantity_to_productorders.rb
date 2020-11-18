class AddQuantityToProductorders < ActiveRecord::Migration[6.0]
  def change
    add_column :productorders, :quantity, :integer
  end
end
