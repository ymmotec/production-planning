class CreateOpenOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :open_order_details do |t|
      t.integer :product_id
      t.integer :order_id
      t.string :rcv
      t.string :cty
      t.integer :orig_qty
      t.integer :bal_qty
      t.date :orig_date
      t.string :sl
      t.integer :orig_week
      t.string :type
      t.integer :bkd_qty

      t.timestamps
    end
  end
end
