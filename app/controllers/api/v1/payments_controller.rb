class Api::V1::PaymentsController < Api::V1::ApiController
  before_action :doorkeeper_authorize!
  before_action :acc_type_is_seller?

  def index
    @payments = current_user.payments.all
    render json: @payments, status: 200
  end
  private

  def acc_type_is_seller?
       if current_user.accountable_type == "Seller"
         render json: {error: "You are not allowed to do this action"},status:403
       end
  end

  
end
