class MicroTask < ApplicationRecord
  # Associations
  belongs_to :macro_task
  has_many :break_points
  has_and_belongs_to_many :workers, join_table: 'micro_tasks_workers'

  # Validations
  validates :title, :level, presence: true
  validates :level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # Enumerations
  has_enumeration_for :level, with: Level
end
