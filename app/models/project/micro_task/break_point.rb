class Project::MicroTask::BreakPoint < ApplicationRecord
  # Associations
  belongs_to :worker
  belongs_to :micro_task, class_name: Project::MicroTask, foreign_key: :id

  # Validations
  validates :worker, :micro_task, presence: true
  validates :opened, presence: true, on: :update
end
