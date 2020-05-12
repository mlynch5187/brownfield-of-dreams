require 'rails_helper'

RSpec.describe "As an admin on the new tutorial page" do
  before(:each) do

    @admin = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: :admin,
                      token: ENV["GITHUB_TOKEN"])

    @tutorial = Tutorial.create(title: "Tutorial",
                                description: "Nice!",
                                thumbnail: "https://i.kym-cdn.com/photos/images/newsfeed/000/877/049/1ee.png")

    @video = @tutorial.videos.create!({"title"=>"Flow Control in Ruby",
                                        "description"=> Faker::Hipster.paragraph(2, true),
                                        "video_id"=>"tZDBWXZzLPk",
                                        "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
                                        "position"=>1})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit "/admin/dashboard"
  end

  it "Deletes all videos when tutorial is deleted" do

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    visit "/admin/dashboard"
    end
  end
