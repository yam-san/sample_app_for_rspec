require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:task) {create(:task)}

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


end
