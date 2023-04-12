class AddColumnsToSeller < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers , :company_name, :string
    add_column :sellers , :company_address, :string
    add_column :sellers , :company_phone_number, :string
  end
end
