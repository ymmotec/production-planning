class AddOeeToMachines < ActiveRecord::Migration[5.1]
  def change
    add_column :machines, :OEE, :decimal
  end
end
