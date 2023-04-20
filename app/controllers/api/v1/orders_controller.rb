class Api::V1::OrdersController < Api::V1::ApiController
  before_action :set_order, only: %i[ show update destroy ]
  
  before_action :acc_type_is_seller?
  before_action :doorkeeper_authorize!
  def index
    @orders = current_user.orders.all
    render json: @orders, status: 200
  end

  def show
    @order=Order.find(params[:id])
    if current_user.orders.include?(@order)
      render json: {message: "Your order items",order: @order,ordered_items:@order.ordered_items}, status: 200

   else
    render json: {
      error: "Order not found"
    }, status:404
   end
  end

  def create
  if order_params[:payment_method]=="CashOnDelievery"

    @order=Order.new(order_params)
    @order.user_id = current_user.id
    @order.cart=current_user.cart
     @order.save
     
        current_user.cart.line_items.each do |line_item|
        
          @order.ordered_items.create!(         
             instrument_id: line_item.instrument_id,
             quantity:   line_item.quantity 
          )
        end
        
         if @order.save
            render json: {id: @order.id,message: "Order  is created successfully"} , status: 201
           else
         render json: {
         message: "Order not created"
        } , status: 422
      end
          
    
  else

  @order = Order.new(order_payment_params)
  @order.user_id = current_user.id
  @payment = @order.payment

  @payment.user_id = current_user.id
  
  @order.cart_id=current_user.cart_id

  if @order.save
            render json: {message: "Order #{@order.id } is created successfully"} , status: 201
           else
         render json: {
         message: "Order not created"
        } , status: 422
   end
  
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
  end

  def update
    @order= Order.find_by(id: params[:id])
    if current_user.orders.include?(@order)
      @order.update(update_params)
      render json: {message:"Order #{@order.id} record updated Succesfully"}
    else
      render json: {
        error: "Order not found"
      },status: 404
    end
     
  end


  private
    
    def set_order
      @order = Order.find(params[:id])
    rescue
    render json: "Order not found", status: :not_found
    end
    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         render json: {error: "You are not allowed to do this action"},status:403
       end
    end

    
    def update_params
      params.require(:order).permit(:address,:contact_number,:order_status)
    end

    def order_payment_params
      params.require(:order).permit(:address,:contact_number,:payment_method,payment_attributes: [:card_number,:expiry_month,:expiry_year,:cvv,:name_on_the_card])
    end

    def order_params
      params.require(:order).permit(:address,:contact_number,:payment_method)
    end
end
