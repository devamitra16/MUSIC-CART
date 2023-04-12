class AddColumnsToPayment < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :card_number, :string
    add_column :payments, :expiry_month, :integer
    add_column :payments, :expiry_year, :integer
    add_column :payments, :name_on_the_card, :string
    add_column :payments, :pay_amount, :integer
    add_reference :payments, :user, null: false, foreign_key: true
    add_reference :payments, :order, null: false, foreign_key: true
  end
end
