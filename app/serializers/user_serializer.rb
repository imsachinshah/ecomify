class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :password, :created_at, :updated_at
end
