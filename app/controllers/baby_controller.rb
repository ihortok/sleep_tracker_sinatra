# frozen_string_literal: true

# BabyController
class BabyController < ApplicationController
  get '/baby' do
    redirect '/users/sign_in' unless logged_in?

    @baby = current_user.baby
    @baby_params = @baby.baby_params.order(id: :desc)

    redirect '/baby/new' unless @baby.present?

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

    @baby = Baby.new(baby_params)

    if @baby.save
      ImageUploader.new(id: @baby.id, name: :baby_photo, image: params[:photo]).call if params[:photo]

      redirect '/dashboard'
    else
      erb :'baby/new.html', layout: :'layout.html'
    end
  end

  get '/baby/edit' do
    redirect '/users/sign_in' unless logged_in?

    @baby = current_user.baby

    redirect '/baby/new' unless @baby.present?

    erb :'baby/edit.html', layout: :'layout.html'
  end

  post '/baby/update' do
    redirect '/users/sign_in' unless logged_in?

    @baby = current_user.baby

    redirect '/baby/new' unless @baby.present?

    if @baby.update(baby_params)
      ImageUploader.new(id: @baby.id, name: :baby_photo, image: params[:photo]).call if params[:photo]

      redirect '/baby'
    else
      erb :'baby/edit.html', layout: :'layout.html'
    end
  end

  private

  def baby_params
    params.slice(:name, :gender, :date_of_birth, :falling_asleep_hour, :wakening_hour).merge(user: current_user)
  end
end
