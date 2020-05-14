require 'rails_helper'

describe 'User routes are limited' do
  it 'if I try to visit a admin route I get an error' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])

    visit "/admin/dashboard"

    expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    

  end
