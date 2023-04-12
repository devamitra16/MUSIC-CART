class CreateOrderedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :ordered_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :instrument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
