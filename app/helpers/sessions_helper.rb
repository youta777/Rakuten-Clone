module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) # @current_userがnil or falseの場合のみ代入
  end

  def logged_in?
    !!current_user
  end
end
