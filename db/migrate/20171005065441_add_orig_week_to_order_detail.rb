class AddOrigWeekToOrderDetail < ActiveRecord::Migration[5.1]
  def change
    add_column :order_details, :orig_week, :integer
  end
end
