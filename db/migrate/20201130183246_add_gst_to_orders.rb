class AddGstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :gst, :decimal
  end
end
