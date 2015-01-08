class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.text :file
      t.integer :bank_account
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
