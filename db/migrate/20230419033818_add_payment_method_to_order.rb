class AddPaymentMethodToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_method, :string, default: "CashOnDelievery"
  end
end
