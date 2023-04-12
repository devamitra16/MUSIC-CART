class AddColumnsToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers , :address, :string
    add_column :customers , :contact_number, :string
  end
end
