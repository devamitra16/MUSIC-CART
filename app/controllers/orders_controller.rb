class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
   before_action :acc_type_is_seller?, only: [:edit, :new , :index, :show, :create  , :destroy]
  

  def index
    @orders = current_user.orders.all
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
  if order_params[:payment_method]=="CashOnDelievery"

    @order=Order.new(order_params)
    @order.user = current_user
      @order.cart=current_user.cart
     @order.save

  
        current_user.cart.line_items.each do |line_item|
          
          @order.ordered_items.create!(         
             instrument_id: line_item.instrument_id,
             quantity:   line_item.quantity 
          )
        end
          @order.save
  else

  @order = Order.new(order_payment_params)
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
          @order.save

  @payment.order_id=@order.id
  @payment.pay_amount = @order.total_price

  @payment.save 
    @order.save  
    end   
  current_user.cart.line_items.destroy_all
  # Cart.destroy(session[:cart_id])
  # session[:cart_id] = nil

    redirect_to order_path(@order)
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
      # p "ookkk"

      @order.order_status="cancelled"
      @order.save
      # @order.ordered_items.destroy_all
      @order.payment&.destroy
      # @order.destroy
      # @order.save

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_order
      @order = Order.find(params[:id])
    end

  
    def order_payment_params
      params.require(:order).permit(:address,:contact_number,:payment_method,payment_attributes: [:card_number,:expiry_month,:expiry_year,:cvv,:name_on_the_card])
    end

    def order_params
      params.require(:order).permit(:address,:contact_number,:payment_method)
    end

    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         redirect_to root_path, notice: "You are logged in as Seller"
       end
    end
end
