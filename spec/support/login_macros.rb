module LoginMacro
  def login(user)
    visit root_path
    click_link 'Login'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'
  end
end
