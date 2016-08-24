class BreakPoint < ApplicationRecord
  # Associations
  belongs_to :worker
  belongs_to :micro_task

  # Validations
  validates :worker_id, :micro_task_id, presence: true
  validates :opened, presence: true, on: :update
end
