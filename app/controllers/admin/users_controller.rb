module Admin
  class UsersController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    def update
      resource = find_resource(params[:id])
      deposit = resource_params[:balance].to_i - resource.balance
    
      return resource.update(resource_params) unless deposit.positive?
      
      begin
        poll_url = process_payment(deposit, '0771111111')
        sleep(16)
        resource.poll_urls.create!(poll_url: poll_url)
        ActiveRecord::Base.transaction do
          if PaynowStatus.check_transaction_status(poll_url)['status'] == 'Paid'
            resource.update!(balance: resource_params[:balance])
            redirect_to request.referer, notice: "Transfer status: Paid. USD$#{deposit} has been deposited to the account."
          else
            redirect_to request.referer, notice: "Transfer status: #{PaynowStatus.check_transaction_status(poll_url)['status']}."
          end
        end
      rescue ActiveRecord::RecordInvalid => e
        puts 
        redirect_to request.referer, flash: {notice: "Error: #{e}"}
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
