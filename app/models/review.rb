class Review < ApplicationRecord
  
  belongs_to :user
  belongs_to :product
  has_many_attached :images, dependent: :destroy

  validates :rating, presence: true
  validate :valid_review?, on: :create

  def average_rating
    
  end

  private
  def valid_review?
    if Review.find_by(product_id: self.product_id, user_id: self.user_id).present?
      errors.add(:message, "Already Reviewed for this product")
    end
  end
end
