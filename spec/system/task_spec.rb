require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task1) { FactoryBot.create(:task, user: user,  name: 'oldest dead line task', dead_line: '2019-10-04 00:00:00') }
  let!(:task2) { FactoryBot.create(:task, user: user, name: 'タスク1', status: '着手中', created_at: '2021-10-04 00:00:00') }
  let!(:task3) { FactoryBot.create(:task, user: user, name: 'priority is high', priority: 0) }
  before do
    visit new_session_path
    fill_in :session_email, with: 'test@email.com'
    fill_in :session_password, with: 'password'
    click_on "Log in"
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_name, with: 'task'
        fill_in :task_content, with: 'task'
        select 2015, from: :task_dead_line_1i
        select '完了', from: :task_status
        click_on "登録する"
        expect(page).to have_content '完了'
        expect(page).to have_content 'task'
        expect(page).to have_content 2015
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, user: user, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row_created')
        expect(task_list[0]).to have_content 'タスク1'
      end
    end
    context 'タスクが終了期限の昇順に並んでいる場合' do
      it '終了期限が古いタスクが一番上に表示される' do
        click_on :sort_by_dead_line
        task_list = all('.task_row_dead_line')
        expect(task_list[0]).to have_content '2019'
      end
    end
    context 'タスクが優先順位の降順に並んでいる場合' do
      it '優先順が高いタスクが一番上に表示される' do
        click_on :sort_by_priority
        task_list = all('.task_row_priority')
        expect(task_list[0]).to have_content '高'
      end
    end
    context 'タスクが検索された場合' do
      it 'タイトルで検索できる' do
        fill_in :name, with: 'priority is high'
        click_on '検索'
        expect(page).not_to have_content 'タスク1'
        expect(page).to have_content 'priority is high'
      end
      it 'ステータスで検索できる' do
        select '着手中', from: :search
        click_on '検索'
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
      end
      it 'タイトルとステータスで検索できる' do
        fill_in :name, with: '1'
        select '着手中', from: :search
        click_on '検索'
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, user: user, name: 'task')
         visit task_path(task.id)
         expect(page).to have_content 'task'
       end
     end
  end
end
