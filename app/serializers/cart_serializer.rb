class CartSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :total_price, :created_at, :updated_at

  # attribute :line_items do |object|
  #   if object.line_items.present?
  #     object.line_items
  #   end
  # end
end