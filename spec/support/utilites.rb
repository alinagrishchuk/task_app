def valid_signin(user)
  visit root_path
  within '#sign-in' do
    fill_in 'Email',      with: user.email
    fill_in 'Password',   with: user.password
    click_button 'Log in'
  end
end

def fill_and_submit_task title, description
  fill_in 'Title',          with: title
  fill_in 'Description',    with: description
  submit_form
  sleep 2
end

def append_task_list
  visit root_path
  click_link 'new_link'
  fill_and_submit_task 'some title', 'some description'
end

def should_have_form
  should have_selector(".form-section")
end

def should_not_have_form
  should_not have_selector(".form-section")
end





