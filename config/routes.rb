Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show]

  resources :projects do
    resources :tasks, only: [:new, :edit, :destroy]
    resources :permissions
    resources :sections, only: [:new, :create, :edit, :update, :destroy] do
      resources :tasks, only: [:new, :edit, :destroy]
    end
  end

  resources :assignments

  resources :tasks, only: [:index, :create, :update]

  resources :sessions, only: [:create]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/facebook/callback', to: 'sessions#create'

  get '/welcome', to: 'static#welcome'
  get '/about', to: 'static#about'
  root 'static#index'

end
