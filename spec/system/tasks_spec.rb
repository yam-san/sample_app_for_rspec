require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'タスク新規作成ページにアクセス' do
        it '新規作成ページへのアクセスが失敗する'
      end
      context 'タスク編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する'
      end
      context 'タスク詳細ページにアクセス' do
        it 'タスクの詳細が表示される'
      end
      context 'タスク一覧ページにアクセス' do
        it '全てのユーザーのタスク一覧が表示される'
      end
    end
  end

end
