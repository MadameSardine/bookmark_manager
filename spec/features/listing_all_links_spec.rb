require 'spec_helper'

feature "User browses the list of links" do 

	before(:each) {
		Link.create(
			:url => "http://www.makersacademy.com",
			:title => "Makers Academy",
			:tags => [Tag.first_or_create(:text => 'education')],
			:user => User.create(:email => "test@test.com",
					:password => 'test',
					:password_confirmation => 'test'))
		Link.create(
			:url => "http://www.google.com",
            :title => "Google",
            :tags => [Tag.first_or_create(:text => 'search')],
            :user => User.create(:email => "test1@test.com",
					:password => 'test',
					:password_confirmation => 'test'))
    	Link.create(:url => "http://www.bing.com",
            :title => "Bing",
            :tags => [Tag.first_or_create(:text => 'search')],
            :user => User.create(:email => "test2@test.com",
					:password => 'test',
					:password_confirmation => 'test'))
    	Link.create(
    		:url => "http://www.code.org",
            :title => "Code.org",
            :tags => [Tag.first_or_create(:text => 'education')],
            :user => User.create(:email => "test3@test.com",
					:password => 'test',
					:password_confirmation => 'test'))
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Makers Academy")
	end

	scenario "filtered by a tag" do
		visit '/tags/search'
		expect(page).not_to have_content("Makers Academy")
		expect(page).not_to have_content("Code.org")
		expect(page).to have_content("Google")
		expect(page).to have_content("Bing")
	end

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("education")
	end

	scenario "submitted by user" do
		visit '/'
		expect(page).to have_content("Submitted by test@test.com")
	end

end