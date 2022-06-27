require 'rails_helper'

RSpec.feature "Quotes", type: :feature do
  context 'Quotes CRUD' do
    let!(:company) { Company.create(name: 'GIG Motors') }
    let!(:user) { User.create(email: 'gig@gmail.com', password: 'password', company_id: company.id) }
    before { login_as user, scope: :user }
    before { visit quotes_path }

    scenario 'creating quotes' do
      expect(page).to have_text('New quote')
      click_on 'New quote'
      fill_in 'quote_name', with: 'smoove'
      click_button 'Create quote'
      expect(page).to have_content('Quote was successfully created.')
    end

    scenario 'editing quotes' do
      expect(page).to have_text('New quote')

      click_on 'New quote'
      fill_in 'quote_name', with: 'smoove'
      click_button 'Create quote'
      expect(page).to have_content('smoove')

      click_on "Edit", match: :first
      fill_in 'quote_name', with: 'new_smoove'
      click_button 'Update quote'
      expect(page).to have_content('Quote was successfully updated.')
    end

    scenario 'deleting quotes' do
      expect(page).to have_text('New quote')

      click_on 'New quote'
      fill_in 'quote_name', with: 'smoove'
      click_button 'Create quote'
      expect(page).to have_content('smoove')
      click_on "Delete", match: :first
      expect(page).to have_content('Quote was successfully destroyed.')
    end
  end
end