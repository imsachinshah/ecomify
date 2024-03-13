class Category < ApplicationRecord

	has_one_attached :picture

	validates :name, presence: true, uniqueness: true
	validates :description, presence: true

end
