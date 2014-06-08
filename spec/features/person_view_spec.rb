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
		expect(page).to have_link('Add phone number', href: new_phone_number_path)
	end

end
