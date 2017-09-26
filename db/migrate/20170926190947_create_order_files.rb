class CreateOrderFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :order_files do |t|
      t.string :file
      t.date :order_date

      t.timestamps
    end
  end
end
