class RenameColumnIn < ActiveRecord::Migration[6.0]
  def change
    rename_column :instruments, :finish, :color
  end
end
