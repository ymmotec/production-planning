class CreateStockFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_files do |t|
      t.string :file
      t.date :stock_date

      t.timestamps
    end
  end
end
