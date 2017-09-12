Rails.application.routes.draw do
  # breeds routes
  get '/breeds/stats', to: 'breeds#stats'
  post '/breeds/:id/tags', to: 'breeds#update_tags'
  resources :breeds

  # tags routes
  get '/tags/stats', to: 'tags#stats'
  resources :tags, except: [:create]
end
