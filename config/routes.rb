Pilfer::Application.routes.draw do
  get '/dashboard', :to => 'dashboard#show', :as => :dashboard

  resources :apps do
    resources :profiles, :only => :show
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, :only => :create
    end
  end

  root :to => 'welcome#index'
end
