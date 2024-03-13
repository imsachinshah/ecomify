class UserMailer < ApplicationMailer

	def verify_otp
		@user = params[:user]
		@otp = params[:otp].otp
		mail(to: @user.email, subject: "Verify your Account")
	end

end
