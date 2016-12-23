Rails.application.routes.draw do
  root to: 'todo_lists#index'

  get '/register', to: 'groups#new', as: :register_group
  post '/register', to: 'groups#create'
  get '/groups/:id', to: 'groups#edit', as: :edit_group
  patch '/groups/:id', to: 'groups#update'
  delete '/groups/:id', to: 'groups#destroy'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :todo_lists do
    resources :todo_items
  end
end
