class CreateHoneys < ActiveRecord::Migration[6.0]
  def change
    create_table :honeys do |t|
      t.string :type
      t.string :source
      t.string :harvest
      t.string :benefits
      t.string :crystallization
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
