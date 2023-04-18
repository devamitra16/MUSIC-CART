class CreateInstrumentsWishlistsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :instruments, :wishlists
  end
end
