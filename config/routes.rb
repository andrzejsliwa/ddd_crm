Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :home, only: :index do
    collection do
      get 'contacts'
    end
  end

  resources :deals
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :show, :create, :update, :destroy]
      resources :deals, only: [:index, :create]
    end
  end
  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
