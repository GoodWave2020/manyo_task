Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root 'tasks#index'
  namespace :admin do
    resources :users
  end
end
