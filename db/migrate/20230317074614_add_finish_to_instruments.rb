class AddFinishToInstruments < ActiveRecord::Migration[6.0]
  def change
    add_column :instruments, :finish, :string
  end
end
