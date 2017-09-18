class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations do |t|
      t.string :name
      t.text :description
      t.belongs_to :element, index: true
      t.belongs_to :machine, index: true

      t.timestamps
    end
  end
end
