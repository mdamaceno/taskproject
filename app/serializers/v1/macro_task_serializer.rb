class V1::MacroTaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :notes, :created_by, :project_id
  belongs_to :worker
  belongs_to :project
end
