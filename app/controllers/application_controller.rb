# frozen_string_literal: true

# ApplicationController
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '_sessionSuperSecret_'
  end

  before do
    redirect '/users/sign_in' if !logged_in? && request.path_info != '/users/sign_in'

    return if !logged_in? && request.path_info == '/users/sign_in'

    return if logged_in? && request.path_info == '/users/sign_out'

    redirect '/baby/new' if !baby.present? && !(['/baby/new', '/baby/create'].include? request.path_info)
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

    def baby
      current_user.baby
    end

    def user_time_zone
      current_user.time_zone
    end

    def date_formatted_for_datetime_value(date, with_time: true)
      format = if with_time == true
                 '%Y-%m-%dT%H:%M'
               else
                 '%Y-%m-%d'
               end

      date.strftime(format)
    rescue NoMethodError
      nil
    end

    def date_formatted_for_ui(date)
      date.strftime('%Y-%m-%d at %H:%M')
    rescue NoMethodError
      nil
    end
  end
end
