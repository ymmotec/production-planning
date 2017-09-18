class ChangeMachineTable < ActiveRecord::Migration[5.1]
  def change
    change_column :machines, :aditional_times, :decimal
    change_column :machines, :down_times, :decimal
  end
end
