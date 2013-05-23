class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_github_authentication

  protected

  def require_github_authentication
    return unless Pilfer.secured?

    warden.authenticate!
    head :forbidden unless github_authorized?(warden.user)
  end

  def warden
    request.env['warden']
  end

  def github_authorized?(user)
    if github_auth_team
      user.team_member?(github_auth_team)
    elsif github_auth_organization
      user.organization_member?(github_auth_organization)
    else
      false
    end
  end

  def github_auth_team
    ENV['GITHUB_AUTH_TEAM']
  end

  def github_auth_organization
    ENV['GITHUB_AUTH_ORG']
  end
end
