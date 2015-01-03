class Operation < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_account
  belongs_to :operation_type
end
