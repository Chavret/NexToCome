Rails.application.routes.draw do
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
