class CreateOliveoils < ActiveRecord::Migration[6.0]
  def change
    create_table :oliveoils do |t|
      t.string :variety
      t.decimal :acidity
      t.string :appearance
      t.string :aroma
      t.string :taste
      t.string :uses
      t.string :size
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
