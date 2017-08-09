Rails.application.routes.draw do
  root 'sessions#new'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
