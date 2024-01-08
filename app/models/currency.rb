class Currency < ApplicationRecord
  before_save :update_balance
  before_destroy :deduct_balance

  validates :amount, presence: true

  belongs_to :user

  private
  def update_balance
    user.reload.update(balance: user.balance + amount)
  end

  def deduct_balance
    user.reload.update(balance: user.balance - amount)
  end

end
