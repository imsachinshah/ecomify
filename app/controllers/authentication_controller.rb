class AuthenticationController < ApiController

	skip_before_action :authenticate_request

	def login
		@user = User.find_by_email(params[:email])

		if @user&.authenticate(params[:password])
			if @user.activated?
				token = JsonWebToken.encode(@user.id, 1.days.from_now)

				render json: UserSerializer.new(@user, meta: {
					token: token
				}).serializable_hash, status: :ok
			else
				render json: { errors: "Please verify your account first"}, status: :bad_request
			end
		else
			render json: {error: "Unauthorized"}, status: :unauthorized
		end
	end
end