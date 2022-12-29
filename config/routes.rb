Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users
  
  resource :user do
    resources :wallets, only: [:index]
    resources :offers, except: [:index, :show], controller: :user_offers
    get 'dashboard' => 'dashboard#index'
  end

  resources :offers, only: [:index, :show]
end
