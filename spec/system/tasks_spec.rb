require 'rails_helper'

describe 'タスク管理機能' do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end
    context 'ユーザーAがログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end
      it 'ユーザーAが作成したタスクが表示される' do
        #作成済みのタスクの名称が画面常に表示されていることを確認D
        expect(page).to have_content '最初のタスク'
      end
    end
    context 'ユーザーbがログインしている時' do
      before do
        FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
        visit login_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).not_to have_content '最初のタスク'
      end
    end

  end
end