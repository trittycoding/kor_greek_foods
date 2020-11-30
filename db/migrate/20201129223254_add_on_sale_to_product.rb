class AddOnSaleToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :on_sale, :boolean
  end
end
