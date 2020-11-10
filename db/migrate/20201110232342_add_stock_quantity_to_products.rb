class AddStockQuantityToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :stockquantity, :integer
  end
end
