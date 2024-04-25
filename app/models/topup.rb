class Topup < ApplicationRecord
  before_save do
    user.update!(balance: user.balance + self.amount)
  end

  enum :payment_option, { ecocash: 0, cash: 1 }
  belongs_to :user
  
  validates :amount, presence: true
  validates :payment_option, presence: true
  validate :positive_amount
  validate :poll_url_on_ecocash

  private
  def positive_amount
    errors.add(:base, 'Your amount should be greater than 1') if amount.to_i < 1
  end

  def poll_url_on_ecocash
    errors.add(:base, 'Your ecocash transaction has no poll_url.') if ecocash? && poll_url.blank?
  end
end
