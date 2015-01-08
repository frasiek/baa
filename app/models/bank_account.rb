class BankAccount < ActiveRecord::Base
  belongs_to :user

  def self.all_mine(user_id)
    BankAccount.where(user_id: user_id)
  end
end
