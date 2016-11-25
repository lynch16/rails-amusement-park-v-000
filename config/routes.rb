Rails.application.routes.draw do

  resources :users
  resources :attractions

  root to: 'users#new'

  get '/signin', to: 'users#signin'
  delete '/signout', to: 'users#destroy'
  post '/take_ride/:id', to: 'attractions#ride', as: 'take_ride'

end
