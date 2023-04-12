class Api::V1::CartsController < Api::V1::ApiController

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart, only: [:show, :update, :destroy]
  before_action :doorkeeper_authorize!

  

  def show
    @cart=Cart.find(params[:id])
    if @cart
      render json: @cart.line_items, status: 200

   else
    render json: {
      error: "Cart not found"
    } 
   end
  end

  

  def update
    @cart= Cart.find_by(id: params[:id])
    if @cart
      @cart.update(cart_params)
      render json: "Cart record updated Succesfully"
    else
      render json: {
        error: "Cart not found"
      }
    end
  end

  def destroy
    @cart.line_items.destroy_all
   
    render json: "Cart has been emptied"
  
  end

  private
    
    def set_cart
      @cart = Cart.find(params[:id])
    rescue
    render json: "Cart not found", status: :not_found
    end

    
    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "That cart doesn't exist"
    end

end
