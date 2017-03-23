Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  get 'admin', to: 'events#admin'

  resources :events

  resources :preferences, only: [] do
    collection do
      post :save_filters
    end
  end

end
