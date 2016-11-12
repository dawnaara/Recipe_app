Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] 

  resources :recipes do
  	resources :bookmarks, only: [:create, :destroy]
  	resources :ratings, except: [:index, :show]
  end

  get "recipes/modify/:id", to: "recipes#modify", as: :modify_recipe

  resources :tags

  root 'welcome#index'
end
