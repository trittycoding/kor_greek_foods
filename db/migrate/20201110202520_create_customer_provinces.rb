class CreateCustomerProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_provinces do |t|
      t.string :name
      t.string :abbreviation
      t.decimal :taxrate
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
