class AddHstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :hst, :decimal
  end
end
