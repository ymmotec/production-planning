class ChangeOpenOrderDetailAssociationColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :open_order_details, :order_id, :open_order_id
  end
end
