Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'admin', to: 'events#admin'
  root to: 'events#index'

  resources :events

  resources :preferences, only: [] do
    collection do
      post :save_filters
    end
  end

end
