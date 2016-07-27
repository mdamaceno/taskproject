class Project::MacroTask < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :worker, foreign_key: 'created_by'
  has_many :micro_tasks, class_name: Project::MicroTask, dependent: :destroy, foreign_key: :id

  # Validations
  validates :title, presence: true
end
