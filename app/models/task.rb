class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :dead_line, presence: true
  validates :status, presence: true
end
