class Project < ApplicationRecord
  # Associations
  has_many :macro_tasks, dependent: :destroy

  # Validations
  validates :title, :begin_at, presence: true
end
