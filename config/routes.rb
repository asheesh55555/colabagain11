Rails.application.routes.draw do
  get "/article/invite" => "articles#invite"
  get "/article/approve" => "articles#approve"
   get "/article/delete_request" => "articles#delete_request"
    get "/article/all_frinds" => "articles#all_frinds"
	get "/article/userprof" => "articles#userprofile"
	get "/article/follo" => "articles#follow"
	get "/article/unfollo" => "articles#unfollow"
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
