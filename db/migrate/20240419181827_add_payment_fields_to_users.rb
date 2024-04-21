class AddPaymentFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :ecocash_number, :string
  end
end
