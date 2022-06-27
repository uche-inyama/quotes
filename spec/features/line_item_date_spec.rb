require 'rails_helper'

RSpec.feature "line_item_dates", type: :feature do
  context "line_item_date CRUD" do
    let!(:company) { Company.create(name: 'GIG Motors') }
    let!(:user) { User.create(email: 'gig@gmail.com', password: 'password', company_id: company.id) }
    let!(:quote) { Quote.create(name: 'First quote', company_id: company.id) }

    before { login_as user, scope: :user }
    before { visit quotes_path }

    scenario "creating line_item_date" do
      expect(page).to have_content('Quotes')
      click_on 'First quote'
      expect(page).to have_content('New date')
      click_on 'New date'
      expect(page).to have_button('Create date')
      fill_in "Date", with: Date.current + 1.day
      click_button 'Create date'
      expect(page).to have_content('Date was successfully added.')
    end

    scenario "editing line_item_date" do
      click_on 'First quote'
      expect(page).to have_content('New date')
      click_on 'New date'
      expect(page).to have_button('Create date')
      fill_in "Date", with: Date.current + 1.day
      click_button 'Create date'
      expect(page).to have_content('Date was successfully added.')
      click_on 'Edit'
      expect(page).to have_button('Update date')
      click_on 'Update date'
      expect(page).to have_content('Date was successfully updated.')
    end

    scenario "deleting line_item_date" do
      click_on 'First quote'
      expect(page).to have_content('New date')
      click_on 'New date'
      expect(page).to have_button('Create date')
      fill_in "Date", with: Date.current + 1.day
      click_button 'Create date'
      expect(page).to have_content('Date was successfully added.')
      click_button 'Delete'
      expect(page).to have_content('Date was successfully deleted.')
    end
  end
end