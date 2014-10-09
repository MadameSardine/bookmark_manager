require 'spec_helper'

feature "User adds a new link" do 
	scenario "can't add link if signed out" do
		visit '/'
		expect(page).not_to have_content('Add link')
	end

	scenario "can add link if signed up" do
		visit '/'
		sign_up("test@test.com", 'test', 'test')
		expect(page).not_to have_content('Add link')
	end

	scenario "after signing up" do
		expect(Link.count).to eq(0)
		sign_up("test@test.com", 'test', 'test')
		visit '/links/new'
		add_link("http://www.makersacademy.com/", "Makers Academy")
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq("http://www.makersacademy.com/")
		expect(link.title).to eq("Makers Academy")
	end

	scenario "with a few tags" do
		sign_up("test@test.com", 'test', 'test')
		visit '/links/new'
		add_link("http://www.makerscademy.com/", "Makers Academy", ['education', 'ruby'])
		link = Link.first
		expect(link.tags.map(&:text)).to include("education")
		expect(link.tags.map(&:text)).to include("ruby")
	end 

	scenario "with a description" do
		sign_up("test@test.com", 'test', 'test')
		visit'/links/new'
		add_link("http://www.makerscademy.com/", "Makers Academy", ['education', 'ruby'], 'Coding bootcamp in London')
		link = Link.first
		expect(link.description).to eq('Coding bootcamp in London')
	end

	def add_link(url, title, tags =[], description="")
		within('#new-link') do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			# our tags will be space separated
			fill_in 'tags', :with => tags.join(' ')
			fill_in 'description', :with => description
			click_button 'Add link'
		end
	end
end
