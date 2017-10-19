class CreateCom40s < ActiveRecord::Migration[5.1]
  def change
    create_table :com40s do |t|
      t.integer :product_id
      t.integer :quantity_in_stock
      t.integer :com40_file_id

      t.timestamps
    end
  end
end
