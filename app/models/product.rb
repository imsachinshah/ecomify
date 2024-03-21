class Product < ApplicationRecord
	belongs_to :category
	has_many :reviews, dependent: :destroy
	has_many_attached :images, dependent: :destroy

	validates :name, presence: true
	validates :price, presence: true
	validates :description, presence: true
	
end
