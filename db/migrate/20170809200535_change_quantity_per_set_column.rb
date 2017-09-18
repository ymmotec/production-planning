class ChangeQuantityPerSetColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :elements, :quantity_pet_set, :quantity_per_set
  end
end
