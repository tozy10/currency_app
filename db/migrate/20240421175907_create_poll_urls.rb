class CreatePollUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :poll_urls do |t|
      t.references :user, null: false, foreign_key: true
      t.string :poll_url

      t.timestamps
    end
  end
end
