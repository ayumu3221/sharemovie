Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
  }
  
#管理者側ルーティング
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :lists, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
  end
  
#会員側ルーティング
  scope module: :public do
    root to: "homes#top"
    get "home/about"=>"homes#about"
    post '/users/guest_sign_in', to: 'users#guest_sign_in'
    resources :users, only: [:index, :show, :edit, :update]
    resources :lists do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get '/search', to: 'searches#search'
  end
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
