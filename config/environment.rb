ENV['SINATRA_ENV'] ||= 'development'

require 'sinatra'
require 'dotenv'
require 'sinatra/activerecord'

Dotenv.load

configure :development do
  db = URI.parse(ENV['DEV_DATABASE_URL'])

  set :database, {
    adapter: db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..],
    encoding: 'unicode'
  }
end
