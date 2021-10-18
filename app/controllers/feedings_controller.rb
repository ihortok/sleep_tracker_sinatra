# frozen_string_literal: true

# FeedingsController
class FeedingsController < ApplicationController
  get '/feedings/new' do
    running_feeding

    erb :'feedings/new.html', layout: :'layout.html'
  end

  post '/feedings/create' do
    redirect '/feedings/new' if running_feeding

    result = ActivityCreator.new(**feeding_params).call

    if result.success?
      redirect '/feedings/new'
    else
      p result.error
    end
  end

  post '/feedings/finish' do
    redirect '/feedings/new' unless running_feeding

    result = ActivityTerminator.new(
      running_feeding,
      params[:activity_finished_at],
      current_user.time_zone
    ).call

    if result.success?
      redirect '/dashboard'
    else
      erb :'dashboard.html', layout: :'layout.html', locals: { message: result.error }
    end
  end

  private

  def running_feeding
    @running_feeding ||= baby.feedings.running.first
  end

  def feeding_params
    {
      activity_class: 'Feeding',
      started_at_param: params[:activity_started_at],
      other_params: params.except('activity_started_at').merge(baby_id: baby.id),
      time_zone: current_user.time_zone
    }
  end
end
