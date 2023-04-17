class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show edit update destroy ]
  before_action :acc_type_is_seller?, only: [:edit, :new , :index, :show, :create  , :destroy]
  
  def index
    @payments = Payment.all
    render json: @payments, status: 200
  end

  
  def show
  end

 
  def new
    @payment = Payment.new
    
  end

 
  def edit
  end

  def create
    @order = Order.find params[:order_id]
    
    @payment = current_user.payments.build(payment_params)
   
    @payment.order_id=@order.id
     @payment.pay_amount=@order.total_price
    @payment.save
    #p @payment
    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
   
    def set_payment
      @payment = Payment.find(params[:id])
    end

   
    def payment_params
     params.require(:payment).permit(:card_number, :expiry_month, :expiry_year, :name_on_the_card, :cvv, :title)
    end
    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         redirect_to root_path, notice: "You are logged in as Seller"
       end
    end
end
