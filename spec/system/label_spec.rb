require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:task, name: 'second_task', user: user) }
  before do
    visit new_session_path
    fill_in :session_email, with: 'test@email.com'
    fill_in :session_password, with: 'password'
    click_on "Log in"
    visit tasks_path
  end
  describe 'ラベルの新規作成機能' do
    context 'ラベルの新規作成画面に遷移した場合' do
      it '一般ユーザーはアクセスできない' do
        visit labels_path
        expect(page).to have_content '管理者権限が必要です。'
      end
      it '管理者ユーザーでラベルの新規登録ができる' do
        click_on 'Logout'
        fill_in :session_email, with: 'admin@admin.com'
        fill_in :session_password, with: 'password'
        click_on "Log in"
        visit new_label_path
        fill_in :label_name, with: 'test'
        click_on '登録する'
        expect(page).to have_content 'test'
      end
    end
  end
  describe 'ラベルの一覧表示機能' do
    context 'ラベル一覧画面に遷移したとき' do
      it '登録したラベルが表示されている' do
        click_on 'Logout'
        fill_in :session_email, with: 'admin@admin.com'
        fill_in :session_password, with: 'password'
        click_on "Log in"
        visit labels_path
        expect(page).to have_content 'MyString'
      end
    end
  end
  describe 'タスクへのラベリング' do
    context 'タスクの新規作成画面に遷移した場合' do
      it '登録済みのラベルが表示されている' do
        visit new_task_path
        expect(page).to have_content 'MyString'
      end
      it 'タスクに1つラベリングすることができる' do
        visit new_task_path
        fill_in :task_name, with: 'task'
        fill_in :task_content, with: 'task'
        check 'MyString'
        click_on "登録する"
        expect(page).to have_content 'MyString'
      end
      it '複数のラベリングをすることができる' do
        visit new_task_path
        fill_in :task_name, with: 'task'
        fill_in :task_content, with: 'task'
        check 'MyString'
        check 'YourString'
        click_on "登録する"
        within('table#index_table') do
          expect(page).to have_content 'MyString'
          expect(page).to have_content 'YourString'
        end
      end
    end
    context 'タスクの編集画面に遷移した場合' do
      let!(:labelling) { FactoryBot.create(:labelling, task_id: task.id, label_id: label.id) }
      it 'ラベリング済みのラベルにチェックが付いている' do
        visit edit_task_path(task.id)
        checkbox = find("#task_label_ids_#{label.id}")
        expect(checkbox).to be_checked
      end
      it 'ラベリングを解除することができる' do
        visit edit_task_path(task.id)
        uncheck 'MyString'
        click_on '更新する'
        within('table#index_table') do
          expect(page).not_to have_content 'MyString'
        end
      end
      it '追加でラベリングすることができる' do
        visit edit_task_path(task.id)
        check 'YourString'
        click_on '更新する'
        within('table#index_table') do
          expect(page).to have_content 'YourString'
        end
      end
    end
  end
  describe 'タスクに登録されたラベルの確認' do
    context 'タスク詳細画面に遷移した場合' do
      it '登録されたラベル一覧が表示される' do
        FactoryBot.create(:labelling, task_id: task.id, label_id: label.id)
        FactoryBot.create(:labelling, task_id: task.id, label_id: second_label.id)
        visit task_path(task.id)
        expect(page).to have_content 'MyString'
        expect(page).to have_content 'YourString'
      end
    end
  end
  describe 'ラベルの検索機能' do
    context 'ラベルで検索された場合' do
      it '選ばれたラベルが表示される' do
        FactoryBot.create(:labelling, task_id: task.id, label_id: label.id)
        select 'MyString', from: :label_id
        click_on '検索'
        expect(page).not_to have_content 'second_task'
        expect(page).to have_content 'test_name'
      end
      it '複数ラベルが登録されたタスクが表示される' do
        FactoryBot.create(:labelling, task_id: task.id, label_id: label.id)
        FactoryBot.create(:labelling, task_id: task.id, label_id: second_label.id)
        select 'MyString', from: :label_id
        click_on '検索'
        expect(page).not_to have_content 'second_task'
        expect(page).to have_content 'test_name'
      end
    end
  end
end
