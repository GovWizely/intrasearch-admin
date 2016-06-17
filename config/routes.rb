Rails.application.routes.draw do
  resources :trade_events, only: [:index, :show]

  root 'home#index'
end
