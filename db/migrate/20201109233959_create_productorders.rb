class CreateProductorders < ActiveRecord::Migration[6.0]
  def change
    create_table :productorders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
