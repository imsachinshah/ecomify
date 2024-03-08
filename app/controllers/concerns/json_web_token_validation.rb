require 'jwt'

module JsonWebTokenValidation
	ERROR_CLASSES = [
		JWT::DecodeError,
  	JWT::ExpiredSignature,
	].freeze

	private

	def validate_json_web_token
		token = request.headers[:token] || params[:token]

		begin 
			@token = JsonWebToken.decode(token)
		rescue *ERROR_CLASSES => e
			handle_exception
		end
	end

	def handle_exception(exception)
		case exception
		when JWT::DecodeError
		 	render json: {errors: [token: "Invalid Token"] }, status: :unauthorized
		when JWT::ExpiredSignature
			render json: { errors: [token: "Token has expired"] }, status: :bad_request
		end
	end
end