class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_account
  before_destroy :before_destroy_fn
  after_destroy :after_destroy_fn

  def before_destroy_fn
    @protected_file_name = self.file
    return true
  end

  def after_destroy_fn
    File.delete(@protected_file_name)
    return true
  end
end
