class Worker < ApplicationRecord
  # Validations
  validates :name, :email, :password, :role, :status, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, uniqueness: true
  validates_email_format_of :email

  # Enumerations
  has_enumeration_for :status, with: Status
end
