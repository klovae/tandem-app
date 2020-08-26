Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show]

  resources :projects

  resources :tasks

  resources :permissions, only: [:index, :show, :edit, :update]

  resources :sessions, only: [:create]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  get '/welcome', to: 'static#welcome'
  get '/about', to: 'static#about'
  root 'static#index'

end
