class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :address, :string
    add_column :orders, :contact_number, :string
  end
end
