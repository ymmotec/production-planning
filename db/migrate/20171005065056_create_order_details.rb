class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.integer :product_id
      t.integer :order_id
      t.string :rcv
      t.string :cty
      t.integer :orig_qty
      t.date :orig_date

      t.timestamps
    end
  end
end
