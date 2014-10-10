require './app/models/link'
require './app/models/user'
require './app/models/tag'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] ||
                             "postgres://localhost/bookmark_manager_#{env}")

DataMapper.finalize


