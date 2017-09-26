class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :order_no
      t.integer :customer_id_number
      t.string :rcv
      t.string :cty
      t.integer :orig_week
      t.date :orig_date
      t.date :order_date

      t.timestamps
    end
  end
end
