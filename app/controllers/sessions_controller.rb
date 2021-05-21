class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_parmas[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました'
    else
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
=begin 
* authenticateメソッド
has_secure_passwordを記述した時に、自動で追加された認証のメソッド
引数のpasswordをハッシュ化して,データベースに保存されてあるdigestと一致するか調べる。
* find_byメソッド
ユーザーデータが見つからない場合、変数userはnilとなるので、条件分岐のauthenticateメソッドの処理の前でぼっち演算子を用いて
エラーにならないように回避する
* proivatメソッド
アクションではないユーティリティメソッドはprivateメソッドに定義しておくことを推奨
=end