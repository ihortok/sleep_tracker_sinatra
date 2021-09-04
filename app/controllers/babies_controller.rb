# frozen_string_literal: true

# BabiesController
class BabiesController < ApplicationController
  get '/babies/new' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/dashboard' if current_user.baby.present?

    erb :'babies/new.html', layout: :'layout.html'
  end

  post '/babies/create' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/dashboard' if current_user.baby.present?

    baby = Baby.new(params.merge(user: current_user))

    if baby.save
      redirect '/dashboard'
    else
      erb :'babies/new.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end
end
