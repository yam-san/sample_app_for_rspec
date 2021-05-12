require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) {create(:user)}
  let(:task) {create(:task)}

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      before do
        visit root_path
        click_link 'SignUp'
      end

      context 'フォーム入力値が正常'do
        it 'ユーザーの新規作成ができる'do
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content 'User was successfully created.'
          expect(page).to have_current_path login_path
        end
      end
      context 'メールアドレスが未入力'do
        it 'ユーザーの新規作成が失敗する'do
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content "Email can't be blank" 
          expect(page).to have_current_path users_path
        end
      end
      context 'メールアドレスが既に使用されている' do
        it 'ユーザーの新規作成が失敗する' do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content 'Email has already been taken'
          expect(page).to have_current_path users_path
        end
      end
    end

    describe 'マイページ' do
      it 'マイページへのアクセスが失敗する' do
        visit user_path(user)
        expect(page).to have_content 'Login required'
        expect(page).to have_current_path login_path
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'ユーザー編集' do
      before do
        visit root_path
        click_link 'Mypage'
        click_link 'Edit'
      end

      context 'フォーム入力値が正常'do
        it 'ユーザーの編集ができる' do
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content 'User was successfully updated.'
          expect(page).to have_current_path user_path(user)
        end
      end

      context 'メールアドレスが未入力'do
        it 'ユーザーの編集が失敗する' do
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content "Email can't be blank"
          expect(page).to have_current_path user_path(user)
        end
      end

      context 'メールアドレスが既に使用されている' do
        it 'ユーザーの編集が失敗する' do
          other_user = create(:user)
          fill_in 'Email', with: other_user.email
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content 'Email has already been taken'
          expect(page).to have_current_path user_path(user)
        end
      end

      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          create(:user)
          visit edit_user_path(2)
          expect(page).to have_content 'Forbidden access.'
          expect(page).to have_current_path user_path(user)
        end
      end
    end

    describe 'マイページ' do
      context 'タスク作成' do
        it '新規作成したタスクが表示される' do
          create(:task, title: 'test_title', status: :doing, user: user)
          visit user_path(user)
          expect(page).to have_content 'You have 1 task.'
          expect(page).to have_content 'test_title'
          expect(page).to have_content 'doing'
          expect(page).to have_link 'Show'
          expect(page).to have_link 'Edit'
          expect(page).to have_link 'Destroy'
        end
      end
    end
  end

end

