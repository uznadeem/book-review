Rails.application.routes.draw do
  namespace :api do
    resources :authors, only: [:create, :index, :show, :update]
    resources :books, only: [:create, :index, :show, :update]
    resources :users, only: [:create, :index, :show, :update]
  end
end
