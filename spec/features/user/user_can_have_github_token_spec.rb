require 'rails_helper'

describe 'User' do
  it 'can be created with a github token' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: "25734313ee735ae09e7b911c59fcf10ae1d4816c")

    expect user.token == "25734313ee735ae09e7b911c59fcf10ae1d4816c"
  end
end               
