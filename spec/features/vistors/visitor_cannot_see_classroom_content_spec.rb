require 'rails_helper'

describe 'as a Visitor' do
  it 'cannot see classroom content tutorials' do
    tutorial = Tutorial.create(title: "Baking Cookies",
                                description: "Chocolate Chip and More")
    tutorial_2 = Tutorial.create(title: "Classroom Tutorial",
                                 description: "Tutorials about teaching",
                                 classroom: true)
    tutorial_3 = Tutorial.create(title: "Playing Soccer",
                                description: "Soccer Tips")
    tutorial_4 = Tutorial.create(title: "More About Teaching",
                                 description: "Everything else you need to know",
                                 classroom: true)
    visit '/tutorials'

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(tutorial_3.title)
    expect(page).to_not have_content(tutorial_2.title)
    expect(page).to_not have_content(tutorial_4.title)

  end
end
