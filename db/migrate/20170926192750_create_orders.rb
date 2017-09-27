class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :order
      t.integer :order_file_id

      t.timestamps
      
    end
  end
end
