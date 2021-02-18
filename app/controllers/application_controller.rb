class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :check_xhr_header
  before_action :require_login

  protected

  def require_login
    @current_user = User.find_by(id: session[:user_id])
    return if @current_user
    return nil
  end

  def check_xhr_header
    return if request.xhr?
    render json: { error: '不正なユーザーを検知しました。' }, status: :forbidden
  end
end
