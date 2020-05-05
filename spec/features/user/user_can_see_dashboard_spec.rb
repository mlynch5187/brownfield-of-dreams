require 'rails_helper'

describe 'User' do
  it 'can see a Github section on the dashboard' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: "25734313ee735ae09e7b911c59fcf10ae1d4816c")

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_content("Github")
  end
end
