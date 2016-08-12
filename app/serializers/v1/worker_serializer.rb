class V1::WorkerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :status, :created_at
  has_many :macro_tasks
end
