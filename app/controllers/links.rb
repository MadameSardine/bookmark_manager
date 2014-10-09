post '/links' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end
	description = params["description"]
	Link.create(:url => url, :title => title, :tags => tags, :description => description, :user => current_user)
	redirect to ('/')
end

get '/links/new' do
	erb :"links/new"
end