Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] 

  resources :recipes

  root 'welcome#index'
end
