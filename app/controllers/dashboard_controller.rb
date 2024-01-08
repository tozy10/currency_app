class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def history
    @money_sent = Transfer.where(sender: current_user).order(created_at: :desc)
    @money_received = Transfer.where(receiver: current_user).order(created_at: :desc)
    @currencies = current_user.currencies.order(created_at: :desc)
  end

  def budgets
  end
end
