require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  it "Deletes all videos when tutorial is deleted" do

    admin = create(:admin)
    tutorial = Tutorial.create(title: "Tutorial",
                                description: "Nice!",
                                thumbnail: "https://i.kym-cdn.com/photos/images/newsfeed/000/877/049/1ee.png")
    video1 = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial.id)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'

      video1.destroyed?
      video2.destroyed?
    end
  end
end
