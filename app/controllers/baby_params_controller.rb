# frozen_string_literal: true

# BabyParamsController
class BabyParamsController < ApplicationController
  get '/baby_params/new' do
    erb :'baby_params/new.html', layout: :'layout.html'
  end

  get '/baby_params/:id' do
    @baby_param = current_user.baby.baby_params.find(params[:id])

    erb :'baby_params/show.html', layout: :'layout.html'
  end

  post '/baby_params/create' do
    @baby_param = BabyParam.new(baby_param_params)

    if @baby_param.save
      ImageUploader.new(id: @baby_param.id, name: :baby_param_photo, image: params[:photo]).call if params[:photo]

      redirect '/baby'
    else
      erb :'baby_params/new.html', layout: :'layout.html'
    end
  end

  get '/baby_params/:id/edit' do
    @baby_param = BabyParam.find(params[:id])

    erb :'baby_params/edit.html', layout: :'layout.html'
  end

  post '/baby_params/:id/update' do
    @baby_param = BabyParam.find(params[:id])

    if @baby_param.update(baby_param_params)
      ImageUploader.new(id: @baby_param.id, name: :baby_param_photo, image: params[:photo]).call if params[:photo]

      redirect "/baby_params/#{@baby_param.id}"
    else
      erb :'baby_params/edit.html', layout: :'layout.html'
    end
  end

  post '/baby_params/:id/destroy' do
    @baby_param = current_user.baby.baby_params.find(params[:id])

    if @baby_param.destroy
      redirect '/baby'
    else
      erb :'baby_params/show.html', layout: :'layout.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  private

  def baby_param_params
    params.slice(:weight, :height, :date_of_measurement).merge(baby: current_user.baby)
  end
end
