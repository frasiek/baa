class FrontController < ApplicationController
  before_action :set_new_user, only: [:login, :register, :index]

  def index
  end

  def login
    @page_title = t('login')
    if request.post?
      params = user_params
      if user_id = @auth_user.log_in(params[:email], params[:password])
        session[:user_session_name] = user_id
        redirect_to '/dashboard'
      else
        @user.errors[:email] = t('Wrong email or password')
      end
    end
  end

  def logout
    session[:user_session_name] = 0
    redirect_to '/'
  end

  def register
    @page_title = t('register')
    if request.post?
      @user = User.new(user_params)
      if @user.save
        UserMailer.registration_mail(@user).deliver_now
        flash[:success] = t('Account was added, you need to confirm e-mail address.')
        redirect_to '/'
      end
    end
  end

  private
  def set_new_user
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:email, :new_password, :new_password_confirmation, :password)
  end
end
