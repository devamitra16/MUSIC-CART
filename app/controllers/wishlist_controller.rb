class WishlistController < ApplicationController
    before_action :authenticate_user!
 

	def show
		@user=User.find(params[:id])
		if @user.wishlist.present?
			@wishlist=@user.wishlist
			@wishlist.save
		end
	   	
	end

	def insert
		@user=current_user
	    @instrument=Instrument.find(params[:instrument_id])
	   
	    if @user.accountable_type=="Customer"
	    if @user.wishlist.present?
	    	if @user.wishlist.instruments.include?(@instrument)
	    		flash[:notice]= "Already added"


	        else
	        	@user.wishlist.instruments<<@instrument

	        end
	    else
         @wishlist=@user.create_wishlist(user_id: params[:user_id])
         @user.wishlist.instruments<<@instrument
	    end
	    flash[:notice] ="item added to your wishlist"
      else
      	flash[:notice] ="You are logged in as seller"
      end
	    redirect_to wishlist_path(current_user)

	end

	
  def destroy
  	@user=User.find(params[:id])
  	@wishlist=Wishlist.find(params[:wishlist_id])
  	@instrument=@wishlist.instruments.find(params[:instrument_id])
  	@wishlist.instruments.delete(@instrument)
  	redirect_to wishlist_path(@user)
  end


	
end
