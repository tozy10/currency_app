class Currency < ApplicationRecord
  validates :amount, presence: true

  belongs_to :users
end
