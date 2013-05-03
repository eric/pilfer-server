class WelcomeController < ApplicationController
  skip_before_filter :require_github_authentication
  layout 'public'
end
