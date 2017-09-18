class CreateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :elements do |t|
      t.string :name
      t.string :internal_id_number
      t.integer :quantity_pet_set
      t.integer :product_id

      t.timestamps
    end
  end
end
