class Item < ApplicationRecord
  belongs_to :budget
  
  validates :title, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
