# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  get '/users/sign_in' do
    redirect '/dashboard' and return if logged_in?

    erb :'users/sign_in.html', layout: :'layout.html'
  end

  post '/users/sign_in' do
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/dashboard'
    else
      erb :'/users/sign_in.html', layout: :'layout.html',
                                  locals: { alert: 'Email or password is wrong. Please try again.' }
    end
  end

  post '/users/sign_out' do
    session.clear
    redirect '/users/sign_in'
  end
end
