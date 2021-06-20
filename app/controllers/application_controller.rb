class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def set_locale
    I18.locale = current_user&.locale || :ja
  end
end

=begin 
* current_user
session[:user_id]が存在していればそのままcurrent_userを使用できる。
session[:user_id]がnilの場合はfind_byでデータベースから探し出し、current_userに代入する 
* login_required
ログインしているかどうかチェックする
=end