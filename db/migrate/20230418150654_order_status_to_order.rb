class OrderStatusToOrder < ActiveRecord::Migration[6.0]
 def change
    add_column :orders, :order_status, :string, default: "ordered"
  end
end
