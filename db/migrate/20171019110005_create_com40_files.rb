class CreateCom40Files < ActiveRecord::Migration[5.1]
  def change
    create_table :com40_files do |t|
      t.string :file
      t.date :stock_date

      t.timestamps
    end
  end
end
