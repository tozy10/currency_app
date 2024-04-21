class PollUrl < ApplicationRecord
  belongs_to :user

  validates :poll_url, presence: true
end
