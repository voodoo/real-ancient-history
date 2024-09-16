class UserMailer < ApplicationMailer
  def login_link(user)
    @user = user
    @login_url = login_url(token: @user.login_token)
    mail(to: @user.email, subject: 'Your login link')
  end
end