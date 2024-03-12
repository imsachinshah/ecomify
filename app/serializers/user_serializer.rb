class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :password, :activated, :created_at, :updated_at
end
