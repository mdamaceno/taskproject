class V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :notes, :begin_at, :finish_at
end
