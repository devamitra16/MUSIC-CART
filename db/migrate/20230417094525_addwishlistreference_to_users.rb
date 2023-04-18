class AddwishlistreferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :wishlist, foreign_key: true
  end
end
