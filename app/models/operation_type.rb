class OperationType < ActiveRecord::Base
  has_many :operations
  self.inheritance_column = nil
end
