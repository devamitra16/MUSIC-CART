class Api::V1::PaymentsController < Api::V1::ApiController
  before_action :doorkeeper_authorize!
  skip_before_action :verify_authenticity_token
  def index
    @payments = Payment.all
    render json: @payments, status: 200
  end

  

  
end
