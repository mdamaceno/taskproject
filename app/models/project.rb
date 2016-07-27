class Project < ApplicationRecord
  validates :title, :begin_at, presence: true
end
