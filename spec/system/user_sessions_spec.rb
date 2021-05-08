require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) {create(:user)}

  describe 'ログイン前' do
    context 'フォーム入力値が正常' do
      it 'ログインができる' do
        visit root_path
        click_link 'Login'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content "Login successful"
        expect(page).to have_current_path root_path
      end
    end
    context 'フォームが未入力' do
      it 'ログインに失敗する' do
        visit root_path
        click_link 'Login'
        click_button 'Login'
        expect(page).to have_content "Login failed"
      end
    end

  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウトに成功する' do
        login(user)
        visit root_path
        click_link 'Logout'
        expect(page).to have_content "Logged out"
        expect(page).to have_current_path root_path
      end
    end
  end
end

