require 'rails_helper'

feature "As an admin on the new tutorial page" do
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

  scenario "Shows a form where I can create a new tutorial" do
    VCR.use_cassette('Create New Tutorial') do

    fill_in "Title", with: "My Tutorial"
    fill_in "Description", with: "Tutorial for cool kids"
    fill_in "Thumbnail", with: "https://i.kym-cdn.com/photos/images/newsfeed/000/877/049/1ee.png"

    click_button "Save"

    tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial.id}")

    expect(page).to have_content("Successfully created tutorial!")

    expect(page).to have_content("My Tutorial")
    end
  end

  # it "Tutorial isn't created when fields are missing" do
  #
  #   fill_in "Title", with: ""
  #   fill_in "Description", with: "Tutorial for cool kids"
  #   fill_in "Thumbnail", with: "https://i.kym-cdn.com/photos/images/newsfeed/000/877/049/1ee.png"
  #
  #   click_button "Save"
  #
  #   expect(page).to have_content("Tutorial was unable to be created!")
  #
  #   expect(current_path).to eq("/tutorials/#{tutorial.id}")
  #
  #   fill_in "Title", with: "My Tutorial"
  #   fill_in "Description", with: "My Tutorial"
  #   fill_in "Thumbnail", with: "https://i.kym-cdn.com/photos/images/newsfeed/000/877/049/1ee.png"
  #
  #   click_button "Save"
  #
  #   expect(page).to have_content("Tutorial was unable to be created!")
  # end

    scenario "user submits form with valid YouTube playlist id" do
      expect(page).to have_link("Import YouTube Playlist")

      click_link("Import YouTube Playlist")

      VCR.use_cassette('Import YouTube Playlist 3') do

      expect(current_path).to eq("/admin/playlists/new")

      fill_in "Title", with: "My Tutorial"
      fill_in "Youtube", with: "PLsPLPczX0Jmu1EEXD5wshEqPDzjHTvWZz"
      fill_in "Description", with: "Tutorial for cool kids"
      fill_in "Thumbnail", with: "https://i.kym-cdn.com/photos/images/newsfeed/000/877/049/1ee.png"

      click_button "Submit"

      tutorial = Tutorial.last

      expect(current_path).to eq("/admin/dashboard")

      expect(page).to have_content("Successfully created tutorial! View it here")

      click_link "View it here"

      expect(current_path).to eq("/tutorials/#{tutorial.id}")

      expect(page).to have_css(".video", count: 9)

      expect("The Chesapeake Boys").to appear_before("Nebraska")

      expect("Hopeful").to_not appear_before("Charlie")
      end
    end
  end
