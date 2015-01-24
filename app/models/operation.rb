class Operation < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_account
  belongs_to :operation_type

  def self.all_my_distinct
    where()
  end

end
