class AddNameToSpiFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :spi_files, :name, :string
  end
end
