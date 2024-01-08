class Transfer < ApplicationRecord
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :sender_has_enough_balance

  after_save :update_balance

  private
  def sender_has_enough_balance
    if sender.balance < amount
      errors.add(:amount, "is greater than sender's balance")
    end
  end

  def update_balance
    sender.reload.update(balance: sender.balance - amount)
    receiver.reload.update(balance: receiver.balance + amount)
  end
end
