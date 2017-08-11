# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/register_optional', to: 'users#new_optional'
  post '/register_optional', to: 'users#create_optional'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
end
