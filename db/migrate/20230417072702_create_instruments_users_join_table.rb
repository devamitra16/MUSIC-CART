class CreateInstrumentsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :instruments, :users
  end
end
