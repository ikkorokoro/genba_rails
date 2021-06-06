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

  describe '新規登録機能' do
    let(:login_user) {user_a}

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) {'新規作成のテストを書く'} # <1>  task_nameのデフォルトとして設定

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) {''} # <1>  task_nameを上書きできる

      it 'エラーとなる' do
        # withinのブロックの中でpageの内容を検査することで、探索する範囲を画面内の特定の範囲に納めることができます
        # 今回でいうと#error_explanationの中に'名称を入力してください'というエラーメッセージがあるか検証する
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end

=begin
letについて
  letは呼び出されたタイミングで実行されるため、一度も呼ばれないた時には実行されずじまいとなってしまう
  let!を利用すれば定義した場所でletが実行してくれます
  処理経路上に複数回、同じ名前のletを定義したときは常に下の階層に定義したletが使われる。 <1> 
  だが上書きを多用するとspecのコードの行数が大きくなった時にどのletが最終的に使われるのかわかりずらくなるという難点もあるため。
  適切なバランスで利用するように意識する
  =end