require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  describe 'ログイン前' do
    context 'フォーム入力値が正常' do
      it 'ログインができる'
    end
    context 'フォームが未入力' do
      it 'ログインに失敗する'
    end

  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウトに成功する'
    end
  end
end

