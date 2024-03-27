class LineItemSerializer
  include JSONAPI::Serializer
  attributes :id, :product_id, :cart_id, :quantity, :total_price, :created_at, :updated_at

end