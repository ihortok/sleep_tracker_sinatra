# frozen_string_literal: true

# BabyController
class BabyController < ApplicationController
  get '/baby' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/baby/new' unless current_user.baby.present?

    @baby = current_user.baby

    erb :'baby/show.html', layout: :'layout.html'
  end

  get '/baby/new' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/baby/show' if current_user.baby.present?

    erb :'baby/new.html', layout: :'layout.html'
  end

  post '/baby/create' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/dashboard' if current_user.baby.present?

    baby = Baby.new(params.merge(user: current_user))

    if baby.save
      redirect '/dashboard'
    else
      erb :'baby/new.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  get '/baby/edit' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/baby/new' unless current_user.baby.present?

    @baby = current_user.baby

    erb :'baby/edit.html', layout: :'layout.html'
  end

  post '/baby/update' do
    redirect '/users/sign_in' unless logged_in?

    redirect '/baby/new' unless current_user.baby.present?

    if current_user.baby.update(params)
      redirect '/baby'
    else
      erb :'baby/edit.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end
end
