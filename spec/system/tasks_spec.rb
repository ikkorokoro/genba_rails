require 'rails_helper'

describe 'タスク管理機能' do
  describe '一覧表示機能' do
    #letは呼ばれたタイミングで初めてに実行される
    let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}

    #beforeのログイン処理ではlogin_useのaかbのどちらかがログインするという具合に抽象化して書いておく
    before do
      #taskがcreateされるタイミングで初めてuser_aが呼ばれるのでここで初めてletの処理が行われ,user_aがデータベースに登録される
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end
  
    context 'ユーザーAがログインしている場合' do
      let(:login_user) {user_a}
    
      it 'ユーザーAが作成したタスクが表示される' do
        #作成済みのタスクの名称が画面常に表示されていることを確認D
        expect(page).to have_content '最初のタスク'
      end
    end
    context 'ユーザーbがログインしている時' do
      let(:login_user) {user_b}

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end
end

=begin 
letは呼び出されたタイミングで実行されるため、一度も呼ばれないた時には実行されずじまいとなってしまう
let!を利用すれば定義した場所でletが実行してくれます
=end