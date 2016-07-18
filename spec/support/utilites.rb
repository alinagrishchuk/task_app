def valid_signin(user)
  visit root_path
  within '#sign-in' do
    fill_in 'Email',      with: user.email
    fill_in 'Password',   with: user.password
    click_button 'Log in'
  end
end

def append_task_list
  visit root_path
  click_link 'new_link'
  fill_in 'Title',          with: 'some title'
  fill_in 'Description',    with: 'some description'
  submit_form
end





