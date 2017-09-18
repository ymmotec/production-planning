class AddQuentityOnPaletToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :quantity_on_palet, :integer
  end
end
