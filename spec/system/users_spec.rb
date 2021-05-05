require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォーム入力値が正常'do
        it 'ユーザーの新規作成ができる'
      end
      context 'メールアドレスが未入力'do
        it 'ユーザーの新規作成が失敗する'
      end
      context 'メールアドレスが既に使用されている' do
        it 'ユーザーの新規作成が失敗する'
      end
    end

    describe 'マイページ' do
      it 'マイページへのアクセスが失敗する'
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォーム入力値が正常'do
        it 'ユーザーの編集ができる'
      end
      context 'メールアドレスが未入力'do
        it 'ユーザーの編集が失敗する'
      end
      context 'メールアドレスが既に使用されている' do
        it 'ユーザーの編集が失敗する'
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する'
      end
    end

    describe 'マイページ' do
      context 'タスク作成' do
        it '新規作成したタスクが表示される'
      end
    end
  end

end

