class Api::V1::InstrumentsController < Api::V1::ApiController
  before_action :set_instrument, only: [:show, :update, :destroy]
  before_action :doorkeeper_authorize!
  
   before_action :acc_type_is_customer?, only: [:update, :create]
  def index
  #   if current_user.accountable_type=="Customer"
  #   @instruments = Instrument.all.order("created_at desc")
  # else
  #   @instruments=current_user.instruments
  # end
  #   render json: @instruments, status: 200
     instruments=Instrument.all
     render json: {Instruments: instruments}
  end

  def show
    @instrument=Instrument.find_by(id: params[:id])
    if @instrument

      render json: @instrument, status: 200

   else
    render json: {
      error: "Instrument not found"
    } 
   end
  end

  def create
    p "yhswh"
    @instrument = current_user.instruments.create(instrument_params)
     
    if @instrument.save

      render json: {instrument: @instrument} , status: 200
    else
      render json: {
        message: "Instrument not created"
      } , status: 401
    end
  end

  def update
    @instrument= Instrument.find_by(id: params[:id])
    if @instrument
      @instrument.update(instrument_params)
      render json: @instrument, status: 200
    else
      render json: {
        error: "Instrument not found"
      }
    end
  end

  def destroy
    @instrument=Instrument.find_by(id: params[:id])
    if @instrument
      @instrument.destroy
      render json: "Instrument has been deleted"
    end  
  end

  private
  def set_instrument
      @instrument = Instrument.find(params[:id])
    rescue
    render json: "Instrument not found", status: :not_found
    
    end

     def acc_type_is_customer?
       if current_user.accountable_type == "Customer"
         render json: "You are not allowed to do this action"
       end
    end

    
    def instrument_params
      params.require(:instrument).permit(:brand, :model, :description, :condition, :finish, :title, :price,:quantity, :user_id)
    end
end
