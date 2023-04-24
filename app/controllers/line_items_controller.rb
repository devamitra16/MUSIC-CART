class LineItemsController < ApplicationController
  include CurrentCart
  
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:create]
  before_action :acc_type_is_seller?, only: [:edit, :new , :index, :show, :create  , :destroy]


  def index
    @line_items = LineItem.all
  end

 
  def show
  end

 
  def new
    @line_item = LineItem.new
  end


  def edit
  end


  def create
    instrument = Instrument.find(params[:instrument_id])
    @line_item = @cart.add_instrument(instrument)
    instrument.quantity-=1
    instrument.save!

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Item added to cart.' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
  def add_quantity
    
    @line_item=LineItem.find(params[:id])
    if @line_item.instrument.quantity >=1
     @line_item.quantity+=1
     @line_item.instrument.quantity-=1
     @line_item.instrument.save
     @line_item.save
   


   end
    render json: { quantity: @line_item.quantity }
  end

  def remove_quantity
    @line_item=LineItem.find(params[:id])
    if @line_item.quantity >1
    @line_item.quantity-=1
    @line_item.instrument.quantity+=1
    @line_item.instrument.save
    @line_item.save
    end
   
    render json: { quantity: @line_item.quantity }
  end

 
  def destroy
    @cart = current_user.cart
    @line_item.instrument.quantity+=@line_item.quantity
    @line_item.instrument.save
    @line_item.destroy!
   

    respond_to do |format|
      format.html { redirect_to @cart, notice: 'Item successfully removed.' }
      format.json { head :no_content }
    end
  end

   

  private
    
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    
    def line_item_params
      params.require(:line_item).permit(:instrument_id)
    end
    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         redirect_to root_path, notice: "You are logged in as Seller"
       end
    end


end
