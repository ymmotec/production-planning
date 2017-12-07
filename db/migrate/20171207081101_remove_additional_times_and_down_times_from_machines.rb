class RemoveAdditionalTimesAndDownTimesFromMachines < ActiveRecord::Migration[5.1]
  def up
    remove_column :machines, :aditional_times
    remove_column :machines, :down_times
  end

  def down
    add_column :machines, :aditional_times, :decimal
    add_column :machines, :down_times, :decimal
  end
end
