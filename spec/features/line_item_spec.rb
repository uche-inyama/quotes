require 'rails_helper'

RSpec.feature "line_item", type: :feature do
  context "line_item crud" do
    let!(:company) { Company.create(name: "Quatar Airways") }
    let!(:user) { User.create(email: "uchenry.iny@gmail.com", password: "password", company_id: company.id) }
    let!(:quote) { Quote.create(name: "Second Quote", company_id: company.id) }
    let (:line_item_date) {LineItemDate.create(date: "June 01, 2022", quote_id: quote.id)}

    before {login_as user, scope: :user }
    before { visit quotes_path }

    scenario 'creating line_item' do
      expect(page).to have_content('Quotes')
      click_on 'Second Quote'
      expect(page).to have_content('New date')
      click_on 'New date'
      expect(page).to have_button('Create date')
      fill_in "Date", with: Date.current + 1.day
      click_button 'Create date'
      expect(page).to have_content('Date was successfully added.')
      click_on 'Add item'
      fill_in 'line_item_name', with: 'smoove'
      fill_in 'line_item_quantity', with: 3
      fill_in 'line_item_unit_price', with: 100
      fill_in 'line_item_description', with: 'You snooze you loose'
      click_button 'Create Line item'
      expect(page).to have_content('Item was successfully saved')
    end

    scenario 'updating line_item' do
      expect(page).to have_content('Quotes')
      click_on 'Second Quote'
      expect(page).to have_content('New date')
      click_on 'New date'
      expect(page).to have_button('Create date')
      fill_in "Date", with: Date.current + 1.day
      click_button 'Create date'
      expect(page).to have_content('Date was successfully added.')
      click_on 'Add item'
      fill_in 'line_item_name', with: 'smoove'
      fill_in 'line_item_quantity', with: 3
      fill_in 'line_item_unit_price', with: 100
      fill_in 'line_item_description', with: 'You snooze you loose'
      click_button 'Create Line item'
      expect(page).to have_content('Item was successfully saved')
      within ".line-item__actions" do
        click_on 'Edit'
      end
      expect(page).to have_content('You snooze you loose')
    end

    scenario 'deleting line_item' do
      expect(page).to have_content('Quotes')
      click_on 'Second Quote'
      expect(page).to have_content('New date')
      click_on 'New date'
      expect(page).to have_button('Create date')
      fill_in "Date", with: Date.current + 1.day
      click_button 'Create date'
      expect(page).to have_content('Date was successfully added.')
      click_on 'Add item'
      fill_in 'line_item_name', with: 'smoove'
      fill_in 'line_item_quantity', with: 3
      fill_in 'line_item_unit_price', with: 100
      fill_in 'line_item_description', with: 'You snooze you loose'
      click_button 'Create Line item'
      expect(page).to have_content('smoove')
      within ".line-item__actions" do
        click_on 'Delete'
      end
      expect(page).to have_content('Item was successfully destroyed')
    end
  end
end