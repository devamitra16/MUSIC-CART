class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_cache_buster
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
	protect_from_forgery with: :exception
	include CurrentCart
	before_action :set_cart , :current_cart , :current_wishlist
	private
    def current_cart
      if session[:cart_id]
        cart = Cart.find_by(:id => session[:cart_id])
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end

      if session[:cart_id] == nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    end

     def current_wishlist
      if session[:wishlist_id]
        wishlist = Wishlist.find_by(:id => session[:wishlist_id])
        if wishlist.present?
          @current_wishlist = wishlist
        else
          session[:wishlist_id] = nil
        end
      end

      if session[:wishlist_id] == nil
        @current_wishlist = Wishlist.create
        session[:wishlist_id] = @current_wishlist.id
      end
    end

	
end
