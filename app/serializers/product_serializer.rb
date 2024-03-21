class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :images, :price, :color, :created_at, :updated_at

  attribute :images do |object|
	  if object.images.attached?
      object.images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image) }
    end 
  end
end