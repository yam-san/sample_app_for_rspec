require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:task) {create(:task)}
  let(:user) {create(:user)}

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'タスク新規作成ページにアクセス' do
        it '新規作成ページへのアクセスが失敗する' do
          visit new_task_path
          expect(page).to have_content 'Login required'
          expect(page).to have_current_path login_path
        end
      end

      context 'タスク編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit root_path
          visit edit_task_path(task)
          expect(page).to have_content 'Login required'
          expect(page).to have_current_path login_path
        end
      end

      context 'タスク詳細ページにアクセス' do
        it 'タスクの詳細が表示される' do
          visit task_path(task)
          expect(page).to have_current_path task_path(task)
        end
      end

      context 'タスク一覧ページにアクセス' do
        it '全てのユーザーのタスク一覧が表示される'do
          visit tasks_path
          expect(page).to have_current_path tasks_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'タスク新規登録' do
      before { visit new_task_path }
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成が成功する' do
          fill_in 'Title', with: 'test_title'
          fill_in 'Content', with: 'test_content'
          select :doing, from: 'Status'
          fill_in 'Deadline', with: DateTime.new(2020, 6, 1, 10, 30)
          click_button 'Create Task'
          expect(page).to have_content 'Title: test_title'
          expect(page).to have_content 'Content: test_content'
          expect(page).to have_content 'Status: doing'
          expect(page).to have_content 'Deadline: 2020/6/1 10:30'
          expect(page).to have_current_path task_path(1)
        end
      end

      context 'タイトルが未入力' do
        it 'タスクの新規作成が失敗する' do
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'test_content'
          click_button 'Create Task'
          expect(page).to have_content "Title can't be blank"
          expect(page).to have_current_path tasks_path
        end
      end

      context '登録済のタイトルを入力' do
        it 'タスクの新規作成が失敗する'do
          fill_in 'Title', with: task.title
          fill_in 'Content', with: 'test_content'
          click_button 'Create Task'
          expect(page).to have_content 'Title has already been taken'
          expect(page).to have_current_path tasks_path
        end
      end
    end

    describe 'タスク編集' do
      let!(:task) {create(:task, user: user)}
      let(:other_task) {create(:task, user: user)}
      before { visit edit_task_path(task) }

      context 'フォームの入力値が正常' do
        it 'タスクの編集が成功する' do
          fill_in 'Title', with: 'update_title'
          select :done, from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content 'Title: update_title'
          expect(page).to have_content 'Status: done'
          expect(page).to have_content 'Task was successfully updated.'
          expect(page).to have_current_path task_path(task)
        end
      end

      context 'タイトルが未入力' do
        it 'タスクの編集が失敗する' do
          fill_in 'Title', with: ''
          select :done, from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content "Title can't be blank"
          expect(page).to have_current_path task_path(task)
        end
      end

      context '登録済のタイトルを入力' do
        it 'タスクの編集が失敗する'do
          fill_in 'Title', with: other_task.title
          select :done, from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content 'Title has already been taken'
          expect(page).to have_current_path task_path(task)
        end
      end
    end

    describe 'タスク削除' do
      let!(:task) { create(:task, user: user) }

      it 'タスクの削除が成功する' do
        visit tasks_path
        click_link 'Destroy'
        expect(page.accept_confirm).to eq 'Are you sure?'
        expect(page).to have_content 'Task was successfully destroyed'
        expect(page).to have_current_path tasks_path
        expect(page).to_not have_content task.title
      end
    end
  end

end
