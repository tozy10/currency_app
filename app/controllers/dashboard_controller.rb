class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def history
    @money_sent = Transfer.where(sender: current_user)
    @money_received = Transfer.where(receiver: current_user)
    @currencies = current_user.currencies
  end
end
