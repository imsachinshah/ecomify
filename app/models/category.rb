class Category < ApplicationRecord

	has_one_attached :picture
	has_many :products

	validates :name, presence: true, uniqueness: true
	validates :description, presence: true

end
