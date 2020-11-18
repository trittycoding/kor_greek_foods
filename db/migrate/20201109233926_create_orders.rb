class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.decimal :total
      t.integer :purchasedby
      t.decimal :unitcost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
