require 'rails_helper'

RSpec.describe "As an admin on the new tutorial page" do
  before(:each) do

    @admin = User.create(email: "joe@example.com",
                      first_name: "Joe",
                      last_name: "Biden",
                      password: "password",
                      role: :admin,
                      token: ENV["GITHUB_TOKEN"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit "/admin/tutorials/new"
  end

    it "Allows me to Import YouTube Playlist" do

      expect(page).to have_link("Import YouTube Playlist")

      click_link("Import YouTube Playlist")

      expect(current_path).to eq("/admin/tutorial/new/playlist")

      fill_in 'playlist_id', with: "PLv5J8Y-w11Srt2bPllM1orz_qRu7UDRWI"

      click_button "Submit"

      expect(current_path).to eq("/admin/dashboard")

      expect(page).to have_content("Successfully created tutorial! View it here")
    end
  end
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube
