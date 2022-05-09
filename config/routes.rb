# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'events#index'
  resources :events, only: %i[index show create new] do
    resources :enrollments, only: :create
  end
  resources :users, only: %i[show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
