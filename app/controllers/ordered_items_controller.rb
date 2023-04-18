class OrderedItemsController < ApplicationController
  before_action :set_ordered_item, only: %i[ show edit update destroy ]
  before_action :acc_type_is_seller?, only: [:edit, :new , :index, :show, :create  , :destroy]
  

  def index
    @ordered_items = current_user.OrderedItem.all
  end

  
  def show
  end

  def new
    @ordered_item = OrderedItem.new
  end


  def edit
  end

 
  def create
    instrument = Instrument.find(params[:instrument_id])
    @ordered_item = @order.add_instrument(instrument)

    respond_to do |format|
      if @ordered_item.save
        format.html { redirect_to ordered_item_url(@ordered_item), notice: "Ordered item was successfully created." }
        format.json { render :show, status: :created, location: @ordered_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ordered_item.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @ordered_item.update(ordered_item_params)
        format.html { redirect_to ordered_item_url(@ordered_item), notice: "Ordered item was successfully updated." }
        format.json { render :show, status: :ok, location: @ordered_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ordered_item.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
   @orders = current_user.orders
    @ordered_item.instrument.quantity+=@ordered_item.quantity
    @ordered_item.instrument.save
    @ordered_item.order_status="cancelled"
    @ordered_item.save
   

    respond_to do |format|
      format.html { redirect_to ordered_items_url }
      format.json { head :no_content }
    end
  end

  private
   
    def set_ordered_item
      @ordered_item = OrderedItem.find(params[:id])
    end

 
    def ordered_item_params
      params.require(:ordered_item).permit(:order_id, :instrument_id)
    end
    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         redirect_to root_path, notice: "You are logged in as Seller"
       end
    end
end
