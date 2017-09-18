class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :ikea_number
      t.string :swing_number

      t.timestamps
    end
  end
end
