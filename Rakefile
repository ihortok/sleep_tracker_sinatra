require_relative 'config/environment'

Dir[File.join(__dir__, 'app/models', '*.rb')].each { |file| require_relative file }

require 'sinatra/activerecord/rake'
require 'pry'

task :c do
  Pry.start
end
