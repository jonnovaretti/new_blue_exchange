# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resource :user do
    resources :wallets, only: [:index]
    resources :offers, except: [:show], controller: :user_offers
    resources :dashboard, only: [:index]
  end

  resources :offers, only: %i[index show]
end
