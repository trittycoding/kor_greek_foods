class CreateHerbs < ActiveRecord::Migration[6.0]
  def change
    create_table :herbs do |t|
      t.string :description
      t.string :benefits
      t.string :instructions
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
