Rails.application.routes.draw do
  concern :reviewable do
    resources :reviews, only: [:create, :index]
  end

  namespace :api do
    resources :authors, only: [:create, :index, :show, :update], concerns: :reviewable
    resources :books, only: [:create, :index, :show, :update], concerns: :reviewable
    resources :users, only: [:create, :index, :show, :update]
  end
end
