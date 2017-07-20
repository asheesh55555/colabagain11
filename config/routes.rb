Rails.application.routes.draw do
  devise_for :users
     root to: "home#index"

resources :articles do
  resources :endorses
end

resources :article do
  member do
    put "like", to: "articles#upvote"
    put "dislike", to: "articles#downvote"
  end
end
end
