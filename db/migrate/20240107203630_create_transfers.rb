class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.integer :amount
      t.references :receiver, foreign_key: { to_table: :users }
      t.references :sender, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
