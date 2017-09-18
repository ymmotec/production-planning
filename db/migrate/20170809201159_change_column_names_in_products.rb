class ChangeColumnNamesInProducts < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :ikea_number, :customer_id_number
    rename_column :products, :swing_number, :internal_id_number
  end
end
