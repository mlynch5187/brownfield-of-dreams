require 'rails_helper'

describe 'User' do
  it 'can be created with a github token' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])

    expect user.token == ENV["GITHUB_TOKEN"]
  end
end
