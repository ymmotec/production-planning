class CreateSpis < ActiveRecord::Migration[5.1]
  def change
    create_table :spis do |t|
      t.string :week
      t.integer :qty
      t.integer :product_id
      t.integer :spi_file_id

      t.timestamps
    end
  end
end
