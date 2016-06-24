Rails.application.routes.draw do
  resources :trade_events, only: [:index, :show, :edit, :update]
  devise_for :users

  resources :users, only: %i(index new create)

  root 'home#index'
end
