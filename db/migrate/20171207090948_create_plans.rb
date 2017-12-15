class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.datetime :final_date
      t.timestamps
    end
  end
end
