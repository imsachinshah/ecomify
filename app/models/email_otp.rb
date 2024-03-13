class EmailOtp < ApplicationRecord
  belongs_to :user

  validates :email, presence: true
  validates :otp, presence: true
end
