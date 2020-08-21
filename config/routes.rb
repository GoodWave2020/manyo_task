Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create, :show]
  root 'tasks#index'
end
