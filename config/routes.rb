Rails.application.routes.draw do
  get 'user_page/index'
  get 'profile/index'
  get 'reports/index'
  get 'contacts/index'
  get 'schedules/index'
  get 'artworks/index'
  get 'artworks', to: 'artworks#index'
  get 'schedules', to: 'schedules#index'
  get 'contacts', to: 'contacts#index'
  get 'reports', to: 'reports#index'
  get 'profile', to: 'profile#index'

  # Location
  resources :locations, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :select_for_pdf
      get :download_pdf
    end
  end


  resources :schedules, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :select_for_pdf
      get :download_pdf
      get 'events'
    end
  end

  authenticated :user do
    root 'arts#index', as: :authenticated_root
  end

  unauthenticated do
    root 'arts#index', as: :unauthenticated_root
  end

  # Public Arts
  # config/routes.rb
  get 'public_arts/:user_id', to: 'public_arts#index', as: 'public_arts'
  get 'public_arts/:user_id/arts/:id', to: 'public_arts#show', as: 'public_art'


  resources :public_arts, only: [:show, :index] do
    collection do
      get 'empty'
    end
  end


  # User Page
  get 'user_page/index', to: 'user_page#index'



  # Arts ===========================================================================================
  resources :arts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :select_for_pdf
      get :download_pdf
    end
  end



  get 'select_location_for_pdf', to: 'locations#select_location_for_pdf'


  root 'page#home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
