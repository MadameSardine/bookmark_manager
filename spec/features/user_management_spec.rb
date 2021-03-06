require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers


feature "User signs up" do 
	scenario "when being logged out" do
		expect{sign_up}.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, alice@example.com")
		expect(User.first.email).to eq("alice@example.com")
	end

	scenario "with a password that doesn't match" do
		expect{sign_up('a@a.com', 'pass', 'wrong')}.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end
end

feature "User signs in" do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content("Welcome, test@test.com")
	end
end

feature 'User signs out' do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test')
	end

	scenario 'while being signed in' do
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, test@test.com")
	end
end

feature 'User reset password' do

	before(:each) do
		User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test')
	end

	scenario 'while being logged out' do
		visit 'sessions/new'
		expect(page).to have_content("I forgot my password")
	end

	scenario 'entering his email' do
		visit 'sessions/new'
		click_link "I forgot my password"
		expect(page).to have_content("Please enter your email")
	end

	scenario 'has a password_token' do
		visit '/sessions/reset'
		fill_in 'email', :with => "test@test.com"
		click_button 'Send'
		user = User.first(:email => "test@test.com")
		expect(user.password_token.nil?).to eq(false)
	end

	scenario 'user clicks on link with token' do
		@user = User.first
		@user.update(:password_token => 'token_test')
		visit '/users/reset_password/token_test'
		expect(page).to have_content('Please enter your new password')
	end

end

