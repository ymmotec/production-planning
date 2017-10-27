class CreateSpiInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :spi_infos do |t|
      t.integer :spi_file_id
      t.integer :product_id
      t.string :art_status
      t.integer :store_assets
      t.integer :dc_stock
      t.integer :safety_stock
      t.integer :in_transit
      t.integer :open_orders
      t.integer :sales_forecast
      t.integer :supply_plan

      t.timestamps
    end
  end
end
