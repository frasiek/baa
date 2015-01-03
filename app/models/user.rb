class User < ActiveRecord::Base
  has_many :user_login_history
  has_many :bank_accounts
  has_many :transactions
  after_find :clear_password, :if => :clear_password?
  attr_accessor :new_password, :new_password_confirmation
  validates_confirmation_of :new_password, :if => :password_changed?
  validates_uniqueness_of :email
  before_save :hash_new_password, :if => :password_changed?
  @@clear_password = true

  def password_changed?
    !@new_password.blank?
  end

  def self.show_password!
    @@clear_password = false
  end

  def self.hide_password!
    @@clear_password = true
  end

  private
  def hash_new_password
    self.password_hash = BCrypt::Password.create(@new_password)
  end

  def clear_password
    self.password_hash = nil
  end

  def clear_password?
    return @@clear_password
  end
end
