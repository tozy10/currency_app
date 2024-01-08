class CurrenciesController < ApplicationController
  before_action :authenticate_user!

  def index
    @currencies = current_user.currencies
  end

  def transfer
    
  end

  def transfer_currency
    @reciever = User.find(params[:receiver_id])
    if current_user.transfer(params[:amount], @reciever)
      redirect_to dashboard_path, flash: { notice: "Transfer successful!" }
    else
      redirect_to transfer_currency_path, flash: { alert: "Transfer was unsuccessful!" }
    end
  end

end
