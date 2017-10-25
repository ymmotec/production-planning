class CreateOpenOrderFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :open_order_files do |t|
      t.string :file
      t.date :open_orders_date

      t.timestamps
    end
  end
end
