class MacroTask < ApplicationRecord
  # Associations
  belongs_to :project
  belongs_to :worker, foreign_key: 'created_by'

  # Validations
  validates :title, presence: true
end
