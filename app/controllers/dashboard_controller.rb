# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  get '/dashboard' do
    @activities = SleepsQuery.new(baby).all_during_week_before(
      Time.current.in_time_zone(user_time_zone)
    )

    erb :'dashboard/index.html', layout: :'layout.html'
  end
end
