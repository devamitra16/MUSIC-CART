class Api::V1::InstrumentsController < Api::V1::ApiController
  before_action :set_instrument, only: [:show, :update, :destroy]
  before_action :doorkeeper_authorize!
 
   before_action :acc_type_is_customer?, only: [:update, :create,:destroy]
  def index
    if current_user.accountable_type=="Customer"
    @instruments = Instrument.all.order("created_at desc")
  else
    @instruments=current_user.instruments
  end
    render json: {Instruments:@instruments}, status: 200
    
  end

  def show
    @instrument=Instrument.find_by(id: params[:id])
    if current_user.accountable_type=="Seller"
      if current_user.instruments.exclude?(@instrument) 
        render json: { error: "You are not allowed to view this instrument"}, status: 403
      else
        render json: @instrument, status: 200
      end
    else
    if @instrument

      render json: @instrument, status: 200

   else
    render json: {
      error: "Instrument not found"
    } , status: 404
   end
  end
  end

  def create
    
    @instrument = current_user.instruments.create(instrument_params)
    
    if @instrument.save

      render json: @instrument , status: 201
    else
      render json: {
        message: "Instrument not created"
      } , status: 422
    end
  end

  def update
    @instrument= Instrument.find_by(id: params[:id])
    if current_user.accountable_type=="Seller"
     if current_user.instruments.exclude?(@instrument) 
        render json: { error: "You are not allowed to do this update"}, status: 403
        return
      end
    end
    if @instrument
      @instrument.update(instrument_params)
      render json: {
        message: "Instrument with id #{@instrument.id } is updated successfully"
      } , status: 200
    else
      render json: {
        error: "Instrument not found"
      } , status: 404
    end
  end

  def destroy
    @instrument= Instrument.find_by(id: params[:id])
    if current_user.accountable_type=="Seller"
     if current_user.instruments.exclude?(@instrument) 
        render json: { error: "You are not allowed to do this action"}, status: 403
        return
      end
    end
    if @instrument
      @instrument.destroy
      render json: {
        message: "Instrument is destroyed successfully"
      } , status: 204
    else
      render json: {
        error: "Instrument not found"
      } , status: 404
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
         render json: {error: "You are not allowed to do this action"},status:403
       end
    end

    
     


    
    def instrument_params
      params.require(:instrument).permit(:brand, :model, :description, :condition,:color, :title, :price,:quantity, :user_id)
    end
end
