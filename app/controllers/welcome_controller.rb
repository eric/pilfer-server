class WelcomeController < ApplicationController
  skip_before_filter :require_github_authentication

  def show
    redirect_to(dashboard_path) and return unless Pilfer.secured?
  end
end
