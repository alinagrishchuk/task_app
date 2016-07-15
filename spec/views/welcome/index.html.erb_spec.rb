require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it 'displays authorization block correctly' do
    render
    expect(rendered).to have_content('Welcome to simple task application!')
    expect(rendered).to have_content('Sign up')
    expect(rendered).to have_content('Log in')
  end
end
