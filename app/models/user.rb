class User < ApplicationRecord

	has_secure_password
	has_one :email_otp

	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	validates :password_confirmation, presence: true, on: :create

	def create_otp
		pin = rand(1000..9999)
		otp = ''
		if self.email_otp.present?
			self.email_otp.update(otp: pin)
			otp = self.email_otp
		else
			otp = EmailOtp.create(email: self.email, otp: pin, user: self)
		end

		otp_token = JsonWebToken.encode(otp.id, {user_id: self.id}, 10.minutes.from_now)
		send_otp_verify_mail(otp)
		return otp_token
	end

	def self.ransackable_associations(auth_object = nil)
	  ["email_otp"]
	end

	def self.ransackable_attributes(auth_object = nil)
	  ["activated", "created_at", "email", "id", "id_value", "name", "password_digest", "updated_at"]
    end

	private
	def send_otp_verify_mail(otp)
		UserMailer.with(user: self, otp: otp).verify_otp.deliver_now
	end

end
