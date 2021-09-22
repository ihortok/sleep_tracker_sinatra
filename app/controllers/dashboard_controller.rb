# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  get '/dashboard' do
    redirect '/users/sign_in' unless logged_in?

    @sleeps = SleepsQuery.new(current_user.baby).all_during_week_before(
      Time.current.localtime(current_user.time_zone_offset)
    )

    erb :'dashboard/index.html', layout: :'layout.html'
  end
end
