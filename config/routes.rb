Pilfer::Application.routes.draw do
  get '/dashboard', :to => 'dashboard#show', :as => :dashboard

  resources :apps do
    resources :profiles, :only => :show do
      member do
        get 'file'
      end
    end
  end

  post 'api/v1/profiles' => 'api/v1/profiles#create', :as => :api_profiles

  root :to => 'welcome#index', :as => :home_page
end
