class Api::V1::OrdersController < Api::V1::ApiController
  before_action :set_order, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!
  def index
    @orders = Order.all
    render json: @orders, status: 200
  end

  def show
    @order=Order.find(params[:id])
    if @order
      render json: @order.ordered_items, status: 200

   else
    render json: {
      error: "Order not found"
    } 
   end
  end

  def create
  @order = Order.new(order_params)
  @order.user = current_user
  @payment = @order.payment
  @payment.user = current_user
  @order.save
  current_user.cart.line_items.each do |line_item|
          
          @order.ordered_items.create!(         
             instrument_id: line_item.instrument_id,
             quantity:   line_item.quantity 
          )
          
          end

  
  @payment.pay_amount = @order.total_price
  @payment.save
  @order.save
  if @order.save
      render json: @order, status: 200
    else
      render json: {
        error: "Error Creating.."
      }
    end
  end

  def update
    @order= Order.find_by(id: params[:id])
    if @order
      @order.update(order_params)
      render json: "Order record updated Succesfully"
    else
      render json: {
        error: "Order not found"
      }
    end
     
  end


  private
    
    def set_order
      @order = Order.find(params[:id])
    rescue
    render json: "Order not found", status: :not_found
    end

    
    def order_params
      params.require(:order).permit(:address,:contact_number,payment_attributes: [:card_number,:expiry_month,:expiry_year,:cvv,:name_on_the_card])
    end
end
