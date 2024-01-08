class TransferController < ApplicationController
  before_action :authenticate_user!
  def new
    @transfer = Transfer.new
  end

  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.sender = current_user
    @transfer.receiver = receiver
    
    if @transfer.save
      redirect_to dashboard_path, flash: { notice: 'Transfer successful.' }
    else
      redirect_to new_transfer_path, flash: { notice: @transfer.errors.full_messages }
    end
  end

  private
  def transfer_params
    params.require(:transfer).permit(:amount, :receiver_id)
  end

  def receiver
    @receiver ||= User.find(transfer_params[:receiver_id])
  end
end
