Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show]

  get '/welcome', to: 'static#welcome'
  get '/about', to: 'static#about'
  root 'static#index'
  
end
