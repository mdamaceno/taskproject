class BreakPoint < ApplicationRecord
  # Associations
  belongs_to :worker
  belongs_to :micro_task

  # Validations
  validates :worker, :micro_task, presence: true
  validates :opened, presence: true, on: :update
end
