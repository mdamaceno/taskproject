class Worker < ApplicationRecord
  # Associations
  has_many :macro_tasks, dependent: :nullify, foreign_key: :created_by
  has_many :tokens, class_name: Worker::Token, dependent: :destroy
  has_and_belongs_to_many :micro_tasks, join_table: 'workers_micro_tasks'

  # Validations
  validates :name, :email, :password, :role, :status, presence: true
  validates :password, length: { minimum: 8 }
  validates :status, numericality: { only_integer: true }
  validates :email, uniqueness: true
  validates_email_format_of :email

  # Enumerations
  has_enumeration_for :status, with: Status
end
