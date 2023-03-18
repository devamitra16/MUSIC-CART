class RemoveFinishFromInstruments < ActiveRecord::Migration[6.0]
  def change
    remove_column :instruments, :finish, :string
  end
end
