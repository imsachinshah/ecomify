class UsersController < ApplicationController
  include JsonWebTokenValidation

  before_action :validate_json_web_token, only: [:verify_user, :resend_otp]
  skip_before_action :authenticate_request, only: :create

  def index
    users = User.all 
    render json: users, status: :ok
  end

  def create
    query_email = user_params[:email].downcase
    user = User.where("LOWER(email) = ?", query_email).first

    if user
      render json: { errors: [{ user: "Email already exists" }] }, status: :unprocessable_entity
    else
      @user = User.new(user_params)

      if @user.save
        token = JsonWebToken.encode(@user.id)
        otp_token = @user.create_otp()

        render json: UserSerializer.new(@user, meta: { token: token, otp_token: otp_token }), status: :created
      else
        render json: {errors: [@user.errors]}, status: :unprocessable_entity
      end
    end
  end

  def show

  end

  def destroy

  end

  def verify_user
    otp_decoded = JsonWebToken.decode(params[:otp_token])
    otp_pin = EmailOtp.find(otp_decoded[:id]).otp

    if otp_pin == params[:otp].to_i
      @current_user.update(activated: true)
      render json: {success: "Email OTP is verified"}, status: :ok 
    else
      render json: {error: "OTP is invalid, Please try again"}, status: :bad_request
    end
  end

  def resend_otp
    user = User.find(@token[:id])

    if user.activated?
      render json: {message: "user is already verified"}, status: :unprocessable_entity
    else
      otp_token = user.create_otp()
      otp = user.email_otp
      UserMailer.with(user: user, otp: otp).verify_otp.deliver_now
      render json: {otp_token: otp_token}, status: :ok
    end
  end

  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
