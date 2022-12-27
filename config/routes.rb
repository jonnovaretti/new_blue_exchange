Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resource :user do
    resources :wallets, only: [:index]
  end  
end
