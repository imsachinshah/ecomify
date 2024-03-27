class CartSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :total_price, :created_at, :updated_at

  
end