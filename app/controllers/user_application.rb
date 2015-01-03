class UserApplication < ApplicationController
  before_action :varify_user

  def verify_user
    if @auth_user.logged_in? == false
      redirect_to '/'
    end
  end
end