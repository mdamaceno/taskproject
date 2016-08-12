class V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :notes, :begin_at, :finish_at, :created_at
  has_many :macro_tasks, serializer: V1::MacroTaskSerializer
end
