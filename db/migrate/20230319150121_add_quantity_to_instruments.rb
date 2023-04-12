class AddQuantityToInstruments < ActiveRecord::Migration[6.0]
  def change
    add_column :instruments, :quantity, :integer
  end
end
