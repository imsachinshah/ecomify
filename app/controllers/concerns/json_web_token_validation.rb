require 'jwt'

module JsonWebTokenValidation
	ERROR_CLASSES = [
		JWT::DecodeError,
  	JWT::ExpiredSignature,
	].freeze

	private

	def validate_json_web_token
		token = request.headers[:token] || params[:token]
		otp_token = params[:otp_token] if params[:otp_token].present? 

		begin 
			@token = JsonWebToken.decode(token)
			otp_token = JsonWebToken.decode(otp_token) if params[:otp_token].present?
		rescue *ERROR_CLASSES => e
			handle_exception(e)
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