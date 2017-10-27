class ChangeNameOfTypeField < ActiveRecord::Migration[5.1]
  def change
    rename_column :open_order_details, :type, :mtype
  end
end
