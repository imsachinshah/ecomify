class ReviewSerializer
  include JSONAPI::Serializer
  attributes :id, :rating, :description, :product_id, :user_id, :created_at, :updated_at

  attribute :images do |object|
    if object.images.attached? 
  	  object.images.map do |image|
        Rails.application.routes.url_helpers.rails_blob_url(image) if image.blob.persisted? 
      end
    else
      []
    end
  end
end