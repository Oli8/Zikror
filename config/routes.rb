Rails.application.routes.draw do

  resources :playlists
  resources :songs
  resources :users, :except => [:new]
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  root 'session#new'
  post '/playlists/add_song', to: 'playlists#add_song'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
