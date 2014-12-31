class AuthUser < Object
  attr_reader :user, :user_id

  # @return [AuthUser]
  def initialize(userId)
    @user = nil
    if userId > 0
      if !User.exists?(userId)
        raise UserNotFoundException
      end
      @user = User.find(userId)
      @user_id = @user.user_id
    else
      @user = User.new
      @user_id = 0
    end
    @user.readonly!
  end

  def logged_in?
    return @user_id>0
  end

  def log_in(email, password)
    User.show_password!
    user = User.find_by(email: email)
    User.hide_password!
    hash = BCrypt::Password.new(user.password_hash)
    p user
    if !user.blank? && user.active == true && hash == password
      user.user_id
    else
      return false
    end
  end

end