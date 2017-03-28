Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'sync_calendar', to: 'events#sync_calendar'
  get 'admin', to: 'events#admin'


  root to: 'pages#home'

  resources :events

  resources :preferences, only: [] do
    collection do
      post :save_filters

    end
  end

end
