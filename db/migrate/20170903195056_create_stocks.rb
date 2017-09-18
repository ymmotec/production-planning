class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.integer :quantity_in_stock
      t.integer :stock_file_id

      t.timestamps
    end
  end
end
