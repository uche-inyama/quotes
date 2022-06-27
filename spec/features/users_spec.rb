require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'sign in' do
    let!(:company) { Company.create(name: 'GIG Motors') }
    let!(:user) { User.create(email: 'gig@gmail.com', password: 'password', company_id: company.id) }
    scenario "with correct credentials" do
      visit new_user_session_path
      expect(page).to have_text('Log in')
      within('form') do
        fill_in 'user_email', with: 'gig@gmail.com'
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end

    scenario "With wrong email credential" do
      visit new_user_session_path
      expect(page).to have_text('Log in')
      within('form') do
        fill_in 'user_email', with: 'john.doe@gmail.com'
        fill_in 'user_password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_current_path(current_path)
    end

    scenario "with wrong password credential" do
      visit new_user_session_path
      expect(page).to have_text('Log in')
      within('form') do
        fill_in 'user_email', with: 'gig@gmail.com'
        fill_in 'user_password', with: 'ssapordw'
      end
      click_button 'Log in'
      expect(page).to have_current_path(current_path)
    end
  end
end
