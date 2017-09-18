class CreateMachines < ActiveRecord::Migration[5.1]
  def change
    create_table :machines do |t|
      t.string :name
      t.string :factory
      t.time :aditional_times
      t.time :down_times

      t.timestamps
    end
  end
end
