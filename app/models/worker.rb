class Worker < ApplicationRecord
  # Associations
  has_many :macro_tasks, class_name: Project::MacroTask, dependent: :nullify, foreign_key: :created_by
  has_many :tokens, class_name: Worker::Token, dependent: :destroy

  # Validations
  validates :name, :email, :password, :role, :status, presence: true
  validates :password, length: { minimum: 8 }
  validates :status, numericality: { only_integer: true }
  validates :email, uniqueness: true
  validates_email_format_of :email

  # Enumerations
  has_enumeration_for :status, with: Status
end
