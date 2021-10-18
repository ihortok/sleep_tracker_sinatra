# frozen_string_literal: true

# BabyController
class BabyController < ApplicationController
  get '/baby' do
    @baby_params = baby.baby_params.order(id: :desc)

    erb :'baby/show.html', layout: :'layout.html'
  end

  get '/baby/new' do
    redirect '/baby' if baby.present?

    erb :'baby/new.html', layout: :'layout.html'
  end

  post '/baby/create' do
    redirect '/baby' if baby.present?

    @baby = Baby.new(baby_params)

    if @baby.save
      ImageUploader.new(id: @baby.id, name: :baby_photo, image: params[:photo]).call if params[:photo]

      redirect '/baby'
    else
      erb :'baby/new.html', layout: :'layout.html'
    end
  end

  get '/baby/edit' do
    erb :'baby/edit.html', layout: :'layout.html'
  end

  post '/baby/update' do
    if baby.update(baby_params)
      ImageUploader.new(id: baby.id, name: :baby_photo, image: params[:photo]).call if params[:photo]

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
