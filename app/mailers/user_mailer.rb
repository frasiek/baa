class UserMailer < ApplicationMailer

  public
  def registration_mail(user)
    @email_user = 'bank.analizator@onet.pl'
    @email_host = 'smtp.poczta.onet.pl'
    @email_port = 465
    @email_pass = ENV['MAIL_PASS']

    @user = user
    @url = url_for({:only_path => true, :action=>"confirm", :controller=>"front", :user => user.id, :hash => BCrypt::Password.create(user.id)} )
    delivery_options = {user_name: @email_user,
                        password: @email_pass,
                        address: @email_host,
                        port: @email_port,
                        enable_starttls_auto: true
    }
    mail(to: @user.email,
         subject: "BAA - aktywacja",
         delivery_method_options: delivery_options)
  end

end
