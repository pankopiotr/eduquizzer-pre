# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en/ do
    root 'sessions#new'
    get '/register', to: 'users#new'
    post '/register', to: 'users#create'
    get '/register_optional', to: 'users#new_optional'
    post '/register_optional', to: 'users#create_optional'
    get '/signin', to: 'sessions#new'
    post '/signin', to: 'sessions#create'
    get '/signout', to: 'sessions#destroy'
    get '/interface', to: 'users#show'
    get '/categories/modify', to: 'categories#new'
    post '/categories/modify', to: 'categories#create'
    delete '/categories/modify', to: 'categories#destroy'
    resources :tasks, only: %i[new create edit update]
    resources :quizzes, only: %i[new create index edit update]
    resources :account_activations, param: :activation_token, only: %i[edit]
    resources :password_resets, param: :reset_token, only: %i[new create
                                                              edit update]
    resources :attempts, only: %i[new create]
  end
end
