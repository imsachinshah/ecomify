class CategorySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :picture, :created_at, :updated_at

  attribute :picture do |object|
	  Rails.application.routes.url_helpers.rails_blob_url(object.picture) rescue nil 
  end
end