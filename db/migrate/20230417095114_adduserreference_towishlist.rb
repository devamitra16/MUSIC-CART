class AdduserreferenceTowishlist < ActiveRecord::Migration[6.0]
  def change
    add_reference :wishlists, :user, foreign_key: true
  end
end
