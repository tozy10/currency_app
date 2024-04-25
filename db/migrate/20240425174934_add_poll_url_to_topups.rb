class AddPollUrlToTopups < ActiveRecord::Migration[7.0]
  def change
    add_column :topups, :poll_url, :string
  end
end
