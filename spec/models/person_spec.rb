require 'spec_helper'

describe Person do
  it 'is valid' do
  	person = Person.new(first_name: "Rachel", last_name: "Warbelow")
  	expect(person).to be_valid
  end

  it 'is invalid without a first name' do
  	person = Person.new(first_name: nil, last_name: "Warbelow")
  	expect(person).not_to be_valid
  end

  it 'is invalid without a last name' do
  	person = Person.new(first_name: "Henry", last_name: nil)
  	expect(person).not_to be_valid
  end

end
