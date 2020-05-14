require 'rails_helper'

describe 'as a User' do
  it 'I can see the tutorials index page' do
    user = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: "default",
                      token: ENV["GITHUB_TOKEN"])
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    tutorial= create(:tutorial, title: "How to Brush Your Teeth")

    visit "/tutorials"

    expect(page).to have_content("How to Tie Your Shoes")
    expect(page).to have_content("How to Brush Your Teeth")
  end 
end
