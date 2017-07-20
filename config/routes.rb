Rails.application.routes.draw do
  devise_for :users
     root to: "home#index"

resources :articles do
  resources :endorses
end
end
