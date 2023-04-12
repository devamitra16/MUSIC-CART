class Api::V1::ApiController < ActionController::API
	
	rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
  
    before_action :doorkeeper_authorize!

    def current_user
		@current_user ||=User.find doorkeeper_token[:resource_owner_id]
	end


    private


    def error_404(error)
        render json: {message:error.message}, status: :not_found
    end

    def error_400(error)
        render json: {message:error.message}, status: :bad_request
    end

    def error_500(error)
        render json: {message:error.message}, status: :internal_server_error
    end

    def doorkeeper_authorize!
      
        super
    end
	
end