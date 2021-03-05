class AuthController < ApplicationController

  def sign_up
    user = User.new(registration_params)
    binding.pry
    if user.save
      session[:user_id] = user.id
      payload = {logged_in: true, user: user}
    else
      payload = {logged_in: false, message: "認証に失敗しました。"}
    end
     render json: payload
end

  def sign_in
    user = User.find_by(email: params[:user][:email].downcase)
    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id
      payload = { logged_in: true, user: user }
    else
      payload = { errors: 'メールアドレスまたはパスワードが正しくありません。' }
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
end