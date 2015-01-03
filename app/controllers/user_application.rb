class UserApplication < ApplicationController
  before_action :verify_user

  def initialize
    super
    @selected_menu_items = []
  end

  def verify_user
    if @auth_user.logged_in? == false
      flash[:danger] = t('need_to_login')
      redirect_to '/'
    end
  end
end