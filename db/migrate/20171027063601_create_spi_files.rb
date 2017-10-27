class CreateSpiFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :spi_files do |t|
      t.string :file
      t.date :spi_date

      t.timestamps
    end
  end
end
