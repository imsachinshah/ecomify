class UsersController < ApplicationController

  before_action :authenticate_user

  def index
    user = User.all 
    render json: user, status: :ok
  end

  def create

    query_email = user_params[:email].downcase
    user = User.where("LOWER(email) = ?", query_email).first

    validator - User.new(user_params)

    if user || validator.valid?
      render json: {errors: [
        user: "Email already exists"
      ]}, status: :unprocessable_entity

    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user.id)

      render json: UserSerializer.new(user, meta: {
        token: token
      }), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show

  end

  def destroy

  end

  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
