class LineItemSerializer
  include JSONAPI::Serializer
  attributes :id, :product_id, :cart_id, :quantity, :total_price, :created_at, :updated_at

  attribute :product do |object|
    ProductSerializer.new(object.product).serializable_hash
  end

end