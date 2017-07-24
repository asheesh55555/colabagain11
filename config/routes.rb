Rails.application.routes.draw do
  get "/article/invite" => "articles#invite"
  get "/article/approve" => "articles#approve"
   get "/article/delete_request" => "articles#delete_request"
    get "/article/all_frinds" => "articles#all_frinds"
	get "/article/userprof" => "articles#userprofile"
	get "/article/follo" => "articles#follow"
	get "/article/unfollo" => "articles#unfollow"
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

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

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

        resources :conversations, only: [:create] do
                member do
                  post :close
                end
                resources :messages, only: [:create]

        end
end
