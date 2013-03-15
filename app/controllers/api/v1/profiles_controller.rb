class Api::V1::ProfilesController < ApplicationController
  before_filter :authenticate_token

  def create
    @app.profiles.create!(:hostname     => params[:hostname],
                          :pid          => params[:pid],
                          :description  => params[:description],
                          :payload      => params[:profile],
                          :file_sources => params[:file_contents])
    head :ok
  end

  private
  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      @app = App.find_by_token(token)
    end
  end
end
