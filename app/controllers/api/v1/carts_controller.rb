class Api::V1::CartsController < Api::V1::ApiController

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart, only: [:show,:update, :destroy]
  before_action :doorkeeper_authorize!
  before_action :set_user, only: [:show]
  before_action :acc_type_is_seller?

  

  def show
    if @user.cart==@cart
    @cart=@user.cart
    else
       render json: {
      error: "Cart not found"
    } ,status: 404
    return
    end
    if @cart
      render json: @cart.line_items, status: 200

   else
    render json: {
      error: "Cart not found"
    } ,status: 404
   end

  end

  def insert
    if(params.has_key?(:instrument_id))
      @user=current_user
      instrument=Instrument.find(params[:instrument_id])
      if @user.cart.present?
         @user.cart.line_items.each do |line_item| 
           if line_item.instrument_id==instrument.id
            if instrument.quantity>0
          instrument.update(quantity: instrument.quantity-1)
          line_item.update(quantity: line_item.quantity+1)
          render json: {message: " Instrument #{instrument.id} quantity updated"}, status: 200
          return
          else
            render json: {message: "Instrument not avaiable"}
          end
           end
          end
       
        
          @user.cart.line_items.create(instrument_id: params[:instrument_id],cart_id: @user.cart.id,quantity: 1)
          render json: {message: "Instrument added to cart"},status: 201
      
      end
    else
      render json: {message: "Enter params Correctly"}, status: 422
    end
  end

   def add_quantity
    
    if(params.has_key?(:instrument_id))
      @user=current_user
      instrument=Instrument.find(params[:instrument_id])
      if @user.cart.present?
         @user.cart.line_items.each do |line_item| 
           if line_item.instrument_id==instrument.id
            if instrument.quantity>0
          instrument.update(quantity: instrument.quantity-1)
          line_item.update(quantity: line_item.quantity+1)
          render json: {message: " Instrument #{instrument.id} quantity updated"}, status: 200
          return
          else
            render json: {message: "Instrument not avaiable"}
          end
           end
          end
       
       render json: {message: "Instrument with id #{instrument.id} not avaiable in your cart "}
        
         
      
      end
    else
      render json: {message: "Enter params Correctly"}, status: 422
    end
  
  end

  def remove_quantity
  
  if(params.has_key?(:instrument_id))
      @user=current_user
      instrument=Instrument.find(params[:instrument_id])
      if @user.cart.present?
         @user.cart.line_items.each do |line_item| 
           if line_item.instrument_id==instrument.id
            if line_item.quantity>1
          instrument.update(quantity: instrument.quantity+1)
          line_item.update(quantity: line_item.quantity-1)
          render json: {message: " Instrument #{instrument.id} quantity updated"}, status: 200
          return
          else
           line_item.destroy!
            render json: {message: "Instrument #{instrument.id} has been removed from your cart"} , status: 204
            return
          end
           end
          end
       
       render json: {message: "Instrument with id #{instrument.id} not avaiable in your cart "}
  
      end
    else
      render json: {message: "Enter params Correctly"}, status: 422
    end

  end

  def remove_item

  if(params.has_key?(:instrument_id))
      @user=current_user
      instrument=Instrument.find(params[:instrument_id])
      if @user.cart.present?
         @user.cart.line_items.each do |line_item| 
           if line_item.instrument_id==instrument.id
             line_item.destroy!
             render json: {message: "Instrument #{instrument.id} has been removed from your cart"} , status: 204
          
          return
        end
      end
          
          
       
       render json: {message: "Instrument with id #{instrument.id} is not avaiable in your cart "}, status: 404
  
      end
    else
      render json: {message: "Enter params Correctly"}, status: 422
    end

  end


            





 

  def destroy

    current_user.cart.line_items.destroy_all
   
    render json: "Cart has been emptied", status: 204
  
  end

  private
    
    def set_cart
      @cart = Cart.find(params[:id])
    rescue
    render json: "Cart not found", status: :not_found
    end
    def set_user
      @user=current_user
    end
    
    def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         render json: {error: "You are not allowed to do this action"},status:403
       end
    end
    
    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "That cart doesn't exist"
    end

end
