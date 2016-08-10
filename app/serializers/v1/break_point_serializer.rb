class V1::BreakPointSerializer < ActiveModel::Serializer
  attributes :id, :worker_id, :micro_task_id, :opened
  belongs_to :worker
  belongs_to :micro_task
end
