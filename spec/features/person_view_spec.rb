require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do

	let(:person) { Person.create(first_name: "Bob", last_name: "Johnson") }

	describe 'phone numbers' do

		before(:each) do
			person.phone_numbers.create(number: "1231234")
			person.phone_numbers.create(number: "9994444")
			visit person_path(person)
		end

		it 'shows the phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end

		it 'has a link to add a phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
		end

		it 'adds a new phone number' do
			page.click_link('Add phone number')
			page.fill_in('Number', with: '1231239')
			page.click_button('Create Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('1231239')
		end

		it 'has links to edit a phone number' do
			person.phone_numbers.each do |phone|
				expect(page).to have_link('edit', edit_phone_number_path(phone))
			end
		end

		it 'edits a phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number

			first(:link, "edit").click
			page.fill_in("Number", with: '444-5555')
			page.click_button("Update Phone number")
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('444-5555')
			expect(page).to_not have_content(old_number)
		end

		it 'deletes a phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number

			first(:link, "delete").click
			expect(current_path).to eq(person_path(person))
			expect(page).to_not have_content(old_number)
		end

	end

	describe 'email addresses' do
		before(:each) do
			person.email_addresses.create(address: "one@email.com")
			person.email_addresses.create(address: "two@email.com")
			person.email_addresses.create(address: "three@email.com")
			visit person_path(person)
		end

		it 'lists the email addresses' do
			person.email_addresses.each do |email|
				expect(page).to have_content(email.address)
				expect(page).to have_selector('li', text: email.address)
			end
		end

		it 'has an add email address link' do
			page.click_link('Add email address')
			page.fill_in('Address', with: "test@example.com")
			page.click_button('Create Email address')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content("test@example.com")
		end
	end

end


















