class Link

	include DataMapper::Resource

	property :id, 		Serial
	property :title, 	String
	property :url, 		String
	property :description,	String
	has n, :tags, 		:through => Resource
	has 1, :user, 		:through => Resource

end