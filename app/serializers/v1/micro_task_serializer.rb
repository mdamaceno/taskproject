class V1::MicroTaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :notes, :level, :macro_task_id
  belongs_to :macro_task
  has_many :break_points
end
