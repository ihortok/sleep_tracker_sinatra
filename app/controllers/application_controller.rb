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

  get '/dashboard' do
    redirect '/users/sign_in' and return unless logged_in?

    erb :'/dashboard.html', layout: :'layout.html'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user = User.find_by(id: session[:user_id])
    end
  end
end
