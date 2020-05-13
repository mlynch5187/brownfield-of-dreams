# require 'rails_helper'
#
# feature "User can see their dashboard" do
#   before do
#     Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
#   end
#
#   scenario "user can connect their Github account from their dashboard" do
#     repos_response = File.read('spec/fixtures/git_hub_repos.json')
#     stub_request(:get, 'https://api.github.com/user/repos').
#         to_return(status: 200, body: repos_response, headers: {})
#
#     followers_response = File.read('spec/fixtures/git_hub_followers.json')
#     stub_request(:get, 'https://api.github.com/user/followers').
#         to_return(status: 200, body: followers_response, headers: {})
#
#     following_response = File.read('spec/fixtures/git_hub_following.json')
#     stub_request(:get, 'https://api.github.com/user/following').
#         to_return(status: 200, body: following_response, headers: {})
#
#     user = User.create(email: "joe@example.com",
#                       first_name: "Joe",
#                       last_name: "Biden",
#                       password: "password",
#                       role: "default")
#
#     visit '/'
#
#     click_on "Sign In"
#
#     expect(current_path).to eq(login_path)
#
#     fill_in 'session[email]', with: user.email
#     fill_in 'session[password]', with: user.password
#
#     click_on 'Log In'
#
#
#     click_button 'Connect to Github'
#
#     expect(current_path).to eq(dashboard_path)
#
#     expect(page).to have_content("Github")
#
#     within(first(".repo")) do
#       expect(page).to have_css(".name")
#     end
#
#     within(".github") do
#       expect(page).to have_content("Followers")
#       expect(page).to have_content("Following")
#     end
#
#     within(first(".follower")) do
#       expect(page).to have_css(".follower_name")
#     end
#
#     within(first(".following")) do
#       expect(page).to have_css(".following_name")
#     end
#   end
# end
