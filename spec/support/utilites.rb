def valid_signin(user)
  visit root_path
  within '#sign-in' do
    fill_in 'Email',      with: user.email
    fill_in 'Password',   with: user.password
    click_button 'Log in'
  end
end





