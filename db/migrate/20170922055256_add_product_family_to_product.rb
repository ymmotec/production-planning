class AddProductFamilyToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :product_family_id, :integer
  end
end
