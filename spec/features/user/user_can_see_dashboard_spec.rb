require 'rails_helper'

describe 'User' do
  it 'can see a Github section on the dashboard' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_content("Github")
  end

  it 'cant see a Github section on the dashboard if user is tokenless' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default")

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to_not have_content("Github")
  end

  it 'can see Github five repositories' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".repo", count: 5)

    within(first(".repo")) do
      expect(page).to have_css(".name")
    end
  end

  it 'can see Github followers section' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'


    within(".github") do
      expect(page).to have_content("Followers")
      expect(page).to have_css(".follower", count: 2)
    end

    within(first(".follower")) do
      expect(page).to have_css(".follower_name")
    end
  end

  it 'can see everyone I follow on Github' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    within(".github") do
      expect(page).to have_content("Following")      
      expect(page).to have_css(".following", count: 4)
    end

    within(first(".following")) do
      expect(page).to have_css(".following_name")
    end
  end
end
