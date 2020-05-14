require 'rails_helper'

  describe 'A logged in User' do
    it 'can link their GitHub account' do
      user = User.create(email: "joe@example.com",
                          first_name: "Joe",
                          last_name: "Biden",
                          password: "password",
                          role: "default")

      visit '/'

      click_on "Sign In"

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit dashboard_path

      click_on "Connect to Github"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('Followers')
      expect(page).to have_content('Following')

      expect(page).to_not have_link("Connect to Github")
    end
  end
