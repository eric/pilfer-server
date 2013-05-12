class DashboardController < ApplicationController
  def show
    @apps = App.all
    @minimum = (params[:minimum] || 50).to_i
  end
end
