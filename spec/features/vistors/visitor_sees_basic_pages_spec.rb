require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end
  end

  describe 'on the about page' do
    it 'can see the about me information' do
      visit '/about'

      expect(page).to have_content('Turing Tutorials')
    end
  end

  describe 'on the get started page' do
    it 'can see get started information' do
      visit '/get_started'

      expect(page).to have_content('Get Started')
    end
  end 
end
