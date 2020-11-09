class CreateBees < ActiveRecord::Migration[6.0]
  def change
    create_table :bees do |t|
      t.string :uses
      t.string :source
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
