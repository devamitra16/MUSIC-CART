class WishlistController < ApplicationController
    
  def new

  	@wishlist=Wishlist.new
  	@user=User.find(params[:user_id])
  end

	def show
		@user=User.find(params[:id])
		if @user.wishlist.present?
			@wishlist=@user.wishlist
			@wishlist.save
	   	
	end

	def insert
		@user=current_user
	    @instrument=Instrument.find(params[:instrument_id])
	    # @wishlist=Wishlist.find(params[:wishlist_id])
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
	    redirect_to instruments_path

	end

	# def create
  #   @user=current_user
  #   @wishlist = @user.create_wishlist(user_id: params[:user_id])
  #   @wishlist.user_id=current_user.id
  #   @wishlist.save
  #   respond_to do |format|
  #     if @wishlist.save
  #       format.html { redirect_to @wishlist, notice: 'wishlist was successfully created.' }
  #       format.json { render :show, status: :created, location: @wishlist}
  #     else
  #       format.html { render :new }
  #       format.json { render json: @wishlist.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def destroy
  	@user=User.find(params[:id])
  	@wishlist=Wishlist.find(params[:wishlist_id])
  	@instrument=@wishlist.instruments.find(params[:instrument_id])
  	@wishlist.instruments.delete(@instrument)
  	redirect_to wishlist_path(@user)
  end


	end
end
