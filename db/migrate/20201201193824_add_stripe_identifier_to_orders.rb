class AddStripeIdentifierToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripe_identifier, :string
  end
end
