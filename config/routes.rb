Rails.application.routes.draw do
  resources :ownedgames
  get "all_user_games" => "ownedgames#index"
  get 'games/index'
  resources :games, only: [:show]

  get 'home' => "welcome#home"
  get "index" => "welcome#index"
  #get "*path" => "welcome#home"
  get 'gameview' => "welcome#gameview"

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  root 'welcome#home'
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

end
