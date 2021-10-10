# frozen_string_literal: true

# ApplicationController
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '_sessionSuperSecret_'
  end

  get '/' do
    redirect '/dashboard' and return if logged_in?

    redirect '/users/sign_in'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def user_time_zone
      current_user.time_zone
    end

    def date_formatted_for_datetime_value(date)
      date.strftime('%Y-%m-%dT%H:%M')
    rescue NoMethodError
      nil
    end
  end
end
