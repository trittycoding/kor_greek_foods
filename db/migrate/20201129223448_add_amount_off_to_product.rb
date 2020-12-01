class AddAmountOffToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :amount_off, :decimal
  end
end
