class MacroTask < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :worker, foreign_key: 'created_by'
  has_many :micro_tasks, dependent: :destroy

  # Validations
  validates :title, :created_by, presence: true
end
