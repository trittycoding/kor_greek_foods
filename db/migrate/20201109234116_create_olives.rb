class CreateOlives < ActiveRecord::Migration[6.0]
  def change
    create_table :olives do |t|
      t.string :benefits
      t.string :size
      t.string :storage
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
