# frozen_string_literal: true

# SleepsController
class SleepsController < ApplicationController
  post '/sleeps/create' do
    redirect '/users/sign_in' and return unless logged_in?

    sleep = Sleep.new(sleep_params)

    if sleep.save
      redirect '/dashboard'
    else
      erb :'dashboard.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  private

  def sleep_params
    time_zone_offset = TZInfo::Timezone.get(current_user.time_zone).utc_offset

    sleep_start_at = Time.new(
      params['sleep_start_at']['year'],
      params['sleep_start_at']['month'],
      params['sleep_start_at']['day'],
      params['sleep_start_at']['hour'],
      params['sleep_start_at']['minute'],
      0,
      time_zone_offset
    )

    sleep_end_at = Time.new(
      params['sleep_end_at']['year'],
      params['sleep_end_at']['month'],
      params['sleep_end_at']['day'],
      params['sleep_end_at']['hour'],
      params['sleep_end_at']['minute'],
      0,
      time_zone_offset
    )

    {
      baby: current_user.babies.first,
      start_at: sleep_start_at,
      end_at: sleep_end_at
    }
  end
end
