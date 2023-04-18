class OrderStatusToOrderedItems < ActiveRecord::Migration[6.0]
  def change
    add_column :ordered_items, :order_status, :string, default: "ordered"
  end
end
