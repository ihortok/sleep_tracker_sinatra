# frozen_string_literal: true

# DashboardController
class DashboardController < ApplicationController
  get '/dashboard' do
    redirect '/users/sign_in' unless logged_in?

    @sleeps = current_user.baby.sleeps

    erb :'dashboard/index.html', layout: :'layout.html'
  end
end
