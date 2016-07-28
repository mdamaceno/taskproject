class Project::MicroTask < ApplicationRecord
  # Associations
  belongs_to :macro_task, class_name: Project::MacroTask,
                          foreign_key: :project_macro_task_id
  has_many :break_points, class_name: Project::MicroTask::BreakPoint,
                          foreign_key: :project_micro_task_id
  has_and_belongs_to_many :workers, class_name: Worker,
                          join_table: 'workers_project_micro_tasks',
                          foreign_key: :project_micro_task_id

  # Validations
  validates :title, :level, presence: true
  validates :level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # Enumerations
  has_enumeration_for :level, with: Level
end
