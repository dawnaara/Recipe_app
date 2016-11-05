Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] 

  resources :recipes do
  	resources :bookmarks, only: [:create, :destroy]
  	resources :ratings, except: [:index, :show]
  end

  resources :tags

  root 'welcome#index'
end
