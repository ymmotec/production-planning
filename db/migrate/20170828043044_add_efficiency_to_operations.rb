class AddEfficiencyToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :efficiency_per_shift, :integer
    add_column :operations, :cycle_time, :decimal
  end
end
