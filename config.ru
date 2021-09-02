require_relative 'config/environment'

Dir[File.join(__dir__, 'app/models', '*.rb')].each { |file| require_relative file }

Dir[File.join(__dir__, 'app/controllers', '*.rb')].each do |file|
  require_relative file

  use File.basename(file, '.rb').camelize.constantize
end

run ApplicationController
