Rails.application.routes.draw do
  resources :dashboard, only: :index
  root 'employees#index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :employees do
    resources :profiles
  end

  resources :posts
end
