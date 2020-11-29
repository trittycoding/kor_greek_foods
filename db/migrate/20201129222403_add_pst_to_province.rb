class AddPstToProvince < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :pst, :decimal
  end
end
