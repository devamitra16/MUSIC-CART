module WishList

  private

  def set_wishlist
    @wishlist = nil
    if user_signed_in?
      unless @wishlist = current_user.wishlist
        @wishlist = current_user.create_wishlist
      end

    end
  end
end