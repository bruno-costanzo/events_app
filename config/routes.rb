# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'events#index'
  resources :events, only: %i[index show create new] do
    resources :enrollments, only: %i[create edit update destroy]
  end
  resources :users, only: %i[show]
end
