class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
   before_action :acc_type_is_seller?, only: [:edit, :new , :index, :show, :create  , :destroy]
  

  def index
    @orders = Order.all
  end


  def show
    @order=Order.find(params[:id])
  end

 
  def new
    @order = Order.new
    @order.build_payment
    
  end

 
  def edit
  end

 
  def create
  @order = Order.new(order_params)
  @order.user = current_user
  @payment = @order.payment
  @payment.user = current_user
  
  
  @order.cart=current_user.cart
  @order.save


  
        current_user.cart.line_items.each do |line_item|
        
          @order.ordered_items.create!(         
             instrument_id: line_item.instrument_id,
             quantity:   line_item.quantity 
          )
          
          end

  @payment.order_id=@order.id
  @payment.pay_amount = @order.total_price
  @payment.save 
    @order.save     
  # current_user.cart.line_items.destroy_all
  # Cart.destroy(session[:cart_id])
  # session[:cart_id] = nil
    redirect_to orders_path
  end


 
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_order
      @order = Order.find(params[:id])
    end

  
    def order_params
      params.require(:order).permit(:address,:contact_number,payment_attributes: [:card_number,:expiry_month,:expiry_year,:cvv,:name_on_the_card])
    end
    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         redirect_to root_path, notice: "You are logged in as Seller"
       end
    end
end
