class ApplicationController < ActionController::Base
  helper_method :current_user

  private
  def current_user
    @current_user || = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
=begin 
* current_user
session[:user_id]が存在していればそのままcurrent_userを使用できる。
session[:user_id]がnilの場合はfind_byでデータベースから探し出し、current_userに代入する 
=end