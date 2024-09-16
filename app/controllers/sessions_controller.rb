class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by(email: params[:email].downcase)
    user.generate_login_token
    UserMailer.login_link(user).deliver_later
    redirect_to root_path, notice: 'Check your email for the login link.'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  def login
    user = User.find_by(login_token: params[:token])
    if user && user.login_token_valid?
      session[:user_id] = user.id
      user.update(login_token: nil, login_token_valid_until: nil)
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      redirect_to new_session_path, alert: 'Invalid or expired login link.'
    end
  end
end