class CreateProductionOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :production_orders do |t|
      t.belongs_to :product, index: true
      t.belongs_to :plan, index: true
      t.integer :ordered_qty
      t.string :status
      t.text :notes

      t.timestamps
    end
  end
end
