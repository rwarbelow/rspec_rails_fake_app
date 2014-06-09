require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do

	let(:person) { Person.create(first_name: "Bob", last_name: "Johnson") }

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

end
