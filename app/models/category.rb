class Category < ApplicationRecord

	has_one_attached :picture, dependent: :destroy
	has_many :products, dependent: :destroy

	validates :name, presence: true, uniqueness: true
	validates :description, presence: true

end
