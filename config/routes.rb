# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en/ do
    root 'sessions#new'
    get '/register', to: 'users#new'
    post '/register', to: 'users#create'
    get '/register_optional', to: 'users#new_optional'
    post '/register_optional', to: 'users#create_optional'
    get '/users', to: 'users#index'
    get '/interface', to: 'users#show'
    get '/signin', to: 'sessions#new'
    post '/signin', to: 'sessions#create'
    get '/signout', to: 'sessions#destroy'
    get '/categories/modify', to: 'categories#new'
    post '/categories/modify', to: 'categories#create'
    delete '/categories/modify', to: 'categories#destroy'
    post '/password_check', to: 'attempts#password_check'
    post '/quizzes/(:id)/archive', to: 'quizzes#archive', as: 'archive_quiz'
    post '/tasks/(:id)/archive', to: 'tasks#archive', as: 'archive_task'
    resources :tasks, only: %i[new create index edit update]
    resources :quizzes, only: %i[new create index edit update]
    resources :account_activations, param: :activation_token, only: %i[edit]
    resources :password_resets, param: :reset_token, only: %i[new create
                                                              edit update archive]
    resources :attempts, only: %i[new create index]
  end
end
