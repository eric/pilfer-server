Pilfer::Application.routes.draw do
  authenticated_routes = lambda do
    get '/dashboard', :to => 'dashboard#show', :as => :dashboard

    resources :apps do
      resources :profiles
    end
  end

  if Pilfer.secured?
    github_authenticate(:team => ENV['GITHUB_AUTH_TEAM'], :org => ENV['GITHUB_AUTH_ORG'], &authenticated_routes)
  else
    # TODO: Enable GitHub authentication.
    # if Rails.env.production? && Rails.groups.exclude?('assets')
    #   raise "GITHUB_AUTH_TEAM= or GITHUB_AUTH_ORG= must be specified in production"
    # end

    authenticated_routes.call
  end

  namespace :api do
    namespace :v1 do
      resources :profiles
    end
  end

  root :to => 'welcome#index'
end
