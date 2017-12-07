class AddColumnsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :lack_group, :integer
    add_column :products, :size, :string
    add_column :products, :palet_size, :integer
    add_column :products, :status, :string
    add_column :products, :max_orders_per_week, :integer
    add_column :products, :lead_time, :integer
    add_column :products, :average_spi, :integer
    add_column :products, :average_sale, :integer
    add_column :products, :average_order_qty, :integer
  end
end
