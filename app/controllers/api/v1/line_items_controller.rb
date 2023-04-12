class Api::V1::LineItemsController < Api::V1::ApiController
  include CurrentCart
  
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:create]
  before_action :doorkeeper_authorize!
  skip_before_action :verify_authenticity_token
 

  def update
    @line_item= LineItem.find_by(id: params[:id])
    if @line_item
      @line_item.update(line_item_params)
      render json: "LineItem record updated Succesfully"
    else
      render json: {
        error: "LineItem not found"
      }
    end
  end

  def destroy
    @line_item.instrument.quantity+=@line_item.quantity
    @line_item.instrument.save
    @line_item.destroy!
    render json: "LineItem has been deleted"
  end


  private
    
    def set_line_item
      @line_item = LineItem.find(params[:id])
    rescue
    render json: "lineitem not found", status: :not_found
    end

    
    def line_item_params
      params.require(:line_item).permit(:instrument_id, :quantity)
    end
end
