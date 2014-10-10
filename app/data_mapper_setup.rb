require './app/models/link'
require './app/models/user'
require './app/models/tag'

env = ENV["RACK_ENV"] || "development"
# 'DATABASE_URL' = 'HEROKU_POSTGRESQL_CHARCOAL_URL' if ENV["RACK_ENV"] == 'production'

# DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

DataMapper.setup(:default, ENV['DATABASE_URL'] ||
                             "postgres://localhost/bookmark_manager_#{env}")

DataMapper.finalize


