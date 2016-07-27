class Worker::Token < ApplicationRecord
  # Associations
  belongs_to :worker

  # Validations
  validates :code, presence: true
  validates :code, length: { is: 24 }
end
