module CurrentCart

  private

  def set_cart
    @cart = nil
    if user_signed_in?
      unless @cart = current_user.cart
        @cart = current_user.create_cart
      end

    end
  end
end