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

    baby = Baby.new(baby_params)

    if baby.save!
      ImageUploader.new(id: baby.id, name: baby.name, image: params[:photo]).call if params[:photo]

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

    if current_user.baby.update(baby_params)
      ImageUploader.new(id: current_user.baby.id, name: current_user.baby.name, image: params[:photo]).call if params[:photo]

      redirect '/baby'
    else
      erb :'baby/edit.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  private

  def baby_params
    params.slice(:name, :gender, :date_of_birth, :night_sleep_start, :night_sleep_finish).merge(user: current_user)
  end
end
