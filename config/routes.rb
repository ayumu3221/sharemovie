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
  end
  
#会員側ルーティング
  scope module: :public do
    root to: "homes#top"
    get "home/about"=>"homes#about"
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
    end

    resources :lists do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get '/search', to: 'searches#search'
    
    get 'chat/:id', to: 'chats#show', as: 'chat'
    resources :chats, only: [:create]
  end
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
