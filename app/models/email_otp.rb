class EmailOtp < ApplicationRecord
  belongs_to :user

  validates :email, presence: true
  validates :otp, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "otp", "updated_at", "user_id"]
  end
end
