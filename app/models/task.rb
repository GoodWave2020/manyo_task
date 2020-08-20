class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :dead_line, presence: true
  validates :status, presence: true
  scope :title_search, -> (query) { where('name like ?', "%#{query}%") }
  scope :status_search, -> (query) { where(status: query) }
end
