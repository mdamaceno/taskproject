class MicroTask < ApplicationRecord
  # Associations
  belongs_to :macro_task

  # Validations
  validates :title, :level, presence: true
  validates :level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # Enumerations
  has_enumeration_for :level, with: Level
end
