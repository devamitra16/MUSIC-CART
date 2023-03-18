class AddAccIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :acc_id, :integer
  end
end
