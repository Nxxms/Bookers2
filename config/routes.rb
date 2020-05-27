Rails.application.routes.draw do
  devise_for :users
  # root 'book#index'
  root 'home#home'
  get 'home/about'
  get "users/show" => "users#show"
  resources :books, except: [:new]
  resources :users, only: [:show, :edit, :update, :index]
  #上記ユーザーはマイページ用
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end