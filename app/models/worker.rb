class Worker < ApplicationRecord
  # Associations
  has_many :macro_tasks, class_name: Project::MacroTask, dependent: :nullify, foreign_key: :created_by
  has_many :tokens, class_name: Worker::Token, dependent: :destroy
  has_and_belongs_to_many :project_micro_tasks, class_name: Project::MicroTask,
                                        join_table: 'workers_project_micro_tasks',
                                        foreign_key: :worker_id

  # Validations
  validates :name, :email, :password, :role, :status, presence: true
  validates :password, length: { minimum: 8 }
  validates :status, numericality: { only_integer: true }
  validates :email, uniqueness: true
  validates_email_format_of :email

  # Enumerations
  has_enumeration_for :status, with: Status
end
