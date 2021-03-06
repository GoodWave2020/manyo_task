require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        fill_in :user_name, with: 'user'
        fill_in :user_email, with: 'user@user.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on "登録する"
        expect(page).to have_content 'user@user.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe 'ログイン機能' do
    context 'ログインした場合' do
      it 'ログインすることができる' do
        visit new_session_path
        fill_in :session_email, with: 'test@email.com'
        fill_in :session_password, with: 'password'
        click_on "Log in"
        expect(page).to have_content 'test@email.com'
      end
      it '他人の詳細ページにアクセスできない' do
        visit new_session_path
        fill_in :session_email, with: 'test@email.com'
        fill_in :session_password, with: 'password'
        click_on "Log in"
        visit user_path(admin_user.id)
        expect(page).not_to have_content 'admin_name'
      end
      it 'ログアウトができる' do
        visit new_session_path
        fill_in :session_email, with: 'test@email.com'
        fill_in :session_password, with: 'password'
        click_on "Log in"
        click_on "Logout"
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe '管理機能' do
    before do
    visit new_session_path
    fill_in :session_email, with: 'admin@admin.com'
    fill_in :session_password, with: 'password'
    click_on "Log in"
    end
    context '管理者がログインしたとき' do
      it '管理画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
      it 'ユーザーの新規作成ができる' do
        visit new_admin_user_path
        fill_in :user_name, with: 'user'
        fill_in :user_email, with: 'user@user.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on "登録する"
        expect(page).to have_content 'user@user.com'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(user.id)
        expect(page).to have_content user.name
      end
      it 'ユーザーの編集ができる' do
        visit edit_admin_user_path(user.id)
        fill_in :user_name, with: 'editted name'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on '更新する'
        expect(page).to have_content 'editted name'
      end
      it 'ユーザーを削除できる' do
        visit admin_users_path
        page.accept_confirm do
          page.all(".delete")[0].click_on '削除'
        end
        expect(page).not_to have_content 'test_name'
      end
    end
    context '一般ユーザーがログインしたとき' do
      it '管理画面にアクセスできない' do
        click_on "Logout"
        fill_in :session_email, with: 'test@email.com'
        fill_in :session_password, with: 'password'
        click_on "Log in"
        visit admin_users_path
        expect(page).not_to have_content 'ユーザー一覧'
      end
    end
  end
end
