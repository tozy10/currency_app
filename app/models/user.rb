class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :currencies, dependent: :destroy
  has_many :budgets, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def transfer(amount, user)
    amount.nil? ? amount = 0 : amount
    current_amount = user.balance + amount
    user.reload.update(balance: current_amount) ? true : false
  end
end
