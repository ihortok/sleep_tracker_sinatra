require './config/environment'
require './models'

get '/' do
  'Hello!'
end

get '/users' do
  @users = User.all
  @users.map(&:name)
end
