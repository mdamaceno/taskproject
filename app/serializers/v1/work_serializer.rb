class V1::WorkSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :status, :created_at
end
