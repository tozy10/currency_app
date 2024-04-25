module Admin
  class TopupsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    def create
      return super if resource_params[:payment_option] == 'cash'
      
      topup = Topup.new(resource_params)
      if topup.amount > 1
        begin
          poll_url = process_payment(topup.amount, '0771111111')
          sleep(10)
          
          topup.poll_url = poll_url
          ActiveRecord::Base.transaction do
            if PaynowStatus.check_transaction_status(poll_url)['status'] == 'Paid'
              topup.save!
              redirect_to request.referer, notice: "Transfer status: Paid. #{topup.amount} has been topped up to your account."
            else
              redirect_to request.referer, flash: {error: "Transfer status: #{PaynowStatus.check_transaction_status(poll_url)['status']}."}
            end
          end
        rescue ActiveRecord::RecordInvalid => e
          puts 
          redirect_to request.referer, flash: {notice: e}
        end
      else
        super
      end     
    end
    private
    
    def process_payment(amount, ecocash_number)
      paynow = Paynow.new(ENV['PAYNOW_INTEGRATION_ID'], ENV['PAYNOW_INTEGRATION_KEY'], dashboard_url, dashboard_url)
      payment = paynow.create_payment('App transfer', 'ernesttozy@gmail.com')
      payment.add("Deposit", amount)
      response = paynow.send_mobile(payment, ecocash_number, 'ecocash')
      
      return unless response.success
    
      poll_url = response.poll_url
      PaynowStatus.check_transaction_status(poll_url)['pollurl']
    end
  end
end
