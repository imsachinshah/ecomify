class ApiController < ActionController::API

	before_action :authenticate_request

	private
	def authenticate_request
		header = request.headers[:token]
		decoded = JsonWebToken.decode(header)
		@current_user = User.find_by(id: decoded[:id])
	end
end