# require 'rest_client'

# API_KEY = ENV['MAILGUN_API_KEY']
# API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/sandbox94c896541715440db2bfcd9c53fe428b.mailgun.org"

# RestClient.post API_URL+"/messages",
#     :from => "ev@example.com",
#     :to => "ev@mailgun.net",
#     :subject => "Bookmark Manager - Reset Password",
#     :text => "Dear bookmark manager user, please click on this link to reset your password",
#     :html => "<b>HTML</b> version of the body!"