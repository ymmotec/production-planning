class CreateOpenOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :open_orders do |t|
      t.string :order
      t.integer :open_order_file_id

      t.timestamps
    end
  end
end
