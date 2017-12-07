class ChangeDateTypeForPaletSize < ActiveRecord::Migration[5.1]
  def change
    change_table :Products do |t|
      t.change :palet_size, :decimal
    end
  end
end
