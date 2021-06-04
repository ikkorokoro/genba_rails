require 'rails_helper'

describe 'タスク管理機能' do
    #letは呼ばれたタイミングで初めてに実行される
    let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
    let!(:task_a) {FactoryBot.create(:task, name: '最初のタスク', user: user_a)}
    #beforeのログイン処理ではlogin_useのaかbのどちらかがログインするという具合に抽象化して書いておく
    before do
      #taskがcreateされるタイミングで初めてuser_aが呼ばれるのでここで初めてletの処理が行われ,user_aがデータベースに登録される
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end
    #共通するitがある場合はshared_examples_forでまとめることができる
    shared_examples_for 'ユーザーAが作成したタスクが表示される' do
      it { expect(page).to have_content '最初のタスク' }
    end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている場合' do
      let(:login_user) {user_a}
    
      #作成済みのタスクの名称が画面常に表示されていることを確認D
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーbがログインしている時' do
      let(:login_user) {user_b}

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end
end

=begin 
letは呼び出されたタイミングで実行されるため、一度も呼ばれないた時には実行されずじまいとなってしまう
let!を利用すれば定義した場所でletが実行してくれます
=end