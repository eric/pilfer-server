class DashboardController < ApplicationController
  def show
    @apps = App.all

    @minimum = (params[:minimum] || 50).to_i

    if @apps.length == 0
      App.create!(:name => 'Application')
      @apps = App.all
    end
  end
end
