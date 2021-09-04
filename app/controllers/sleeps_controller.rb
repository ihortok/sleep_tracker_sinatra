# frozen_string_literal: true

# SleepsController
class SleepsController < ApplicationController
  get '/sleeps/new' do
    redirect '/users/sign_in' unless logged_in?

    erb :'sleeps/new.html', layout: :'layout.html'
  end

  post '/sleeps/create' do
    redirect '/users/sign_in' and return unless logged_in?

    sleep = Sleep.new(sleep_params)

    if sleep.save
      redirect '/dashboard'
    else
      erb :'dashboard.html', layout: :'layout.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  private

  def sleep_params
    time_zone_offset = TZInfo::Timezone.get(current_user.time_zone).utc_offset

    sleep_started_at = Time.new(
      params['sleep_started_at']['year'],
      params['sleep_started_at']['month'],
      params['sleep_started_at']['day'],
      params['sleep_started_at']['hour'],
      params['sleep_started_at']['minute'],
      0,
      time_zone_offset
    )

    sleep_finished_at = Time.new(
      params['sleep_finished_at']['year'],
      params['sleep_finished_at']['month'],
      params['sleep_finished_at']['day'],
      params['sleep_finished_at']['hour'],
      params['sleep_finished_at']['minute'],
      0,
      time_zone_offset
    )

    {
      baby: current_user.babies.first,
      started_at: sleep_started_at,
      finished_at: sleep_finished_at
    }
  end
end
