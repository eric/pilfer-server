class DashboardController < ApplicationController
  def show
    @apps = App.all

    if @apps.length == 0
      App.create!(:name => 'Application')
      @apps = App.all
    end
  end
end
