class AddLimitsInfoToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :min_production, :integer
    add_column :products, :max_production, :integer
    add_column :products, :min_stock, :integer
    add_column :products, :max_stock, :integer
  end
end
