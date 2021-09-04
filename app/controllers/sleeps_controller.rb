# frozen_string_literal: true

# SleepsController
class SleepsController < ApplicationController
  get '/sleeps/new' do
    redirect '/users/sign_in' unless logged_in?

    set_running_sleep

    erb :'sleeps/new.html', layout: :'layout.html'
  end

  post '/sleeps/create' do
    redirect '/users/sign_in' and return unless logged_in?

    set_running_sleep

    redirect '/sleeps/new' if @running_sleep

    sleep = Sleep.new(sleep_params)

    if sleep.save
      redirect '/dashboard'
    else
      erb :'dashboard.html', layout: :'layout.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  post '/sleeps/finish' do
    redirect '/users/sign_in' and return unless logged_in?

    set_running_sleep

    redirect '/sleeps/new' unless @running_sleep

    sleep_finished_at = Time.new(
      params['sleep_finished_at']['year'],
      params['sleep_finished_at']['month'],
      params['sleep_finished_at']['day'],
      params['sleep_finished_at']['hour'],
      params['sleep_finished_at']['minute'],
      0,
      time_zone_offset
    )

    if @running_sleep.update({ finished_at: sleep_finished_at, status: :finished })
      redirect '/dashboard'
    else
      erb :'dashboard.html', layout: :'layout.html', locals: { message: 'Something went wrong. Please try again.' }
    end
  end

  private

  def sleep_params
    sleep_started_at = Time.new(
      params['sleep_started_at']['year'],
      params['sleep_started_at']['month'],
      params['sleep_started_at']['day'],
      params['sleep_started_at']['hour'],
      params['sleep_started_at']['minute'],
      0,
      time_zone_offset
    )

    finished_at_hour = params['sleep_finished_at']['hour']
    finished_at_minute = params['sleep_finished_at']['minute']

    if finished_at_hour.present? && finished_at_minute.present?
      status = :finished
      sleep_finished_at = Time.new(
        params['sleep_finished_at']['year'],
        params['sleep_finished_at']['month'],
        params['sleep_finished_at']['day'],
        finished_at_hour,
        finished_at_minute,
        0,
        time_zone_offset
      )
    else
      status = :running
    end

    {
      baby: current_user.baby,
      started_at: sleep_started_at,
      finished_at: sleep_finished_at,
      status: status
    }
  end

  def time_zone_offset
    @time_zone_offset ||= TZInfo::Timezone.get(current_user.time_zone).utc_offset
  end

  def set_running_sleep
    @running_sleep = current_user.baby.sleeps.running.first
  end
end
