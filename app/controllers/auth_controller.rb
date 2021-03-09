class AuthController < ApplicationController

  def sign_up
    user = User.new(registration_params)
    payload = check_signup(user)
    render json: payload
  end

  def sign_in
    user = User.find_by(email: params[:user][:email].downcase)
    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id
      payload = { logged_in: true, user: user }
    else
      payload = { logged_in: false, errors: 'メールアドレスまたはパスワードが正しくありません。' }
    end
    render json: payload
  end


  def sign_out
    session.destroy
    render json: {logged_in: false}
  end

  def check_login
    if @current_user
      payload = { user: @current_user, logged_in: true }
    else
      payload = { logged_in: false, status: 401}
    end
    render json: payload
  end

  private
  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def check_signup(user)
    if user.valid?
      user.save!
      session[:user_id] = user.id
      payload = {logged_in: true, user: user}
    elsif user.errors.full_messages.include?("Email has already been taken")
      payload = {logged_in: false, errors: "入力されたメールアドレスは既に登録されています。"}
    else
      binding.pry
      payload = {logged_in: false, errors: "認証に失敗しました。"}
    end
  end
end