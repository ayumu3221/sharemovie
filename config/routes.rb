Rails.application.routes.draw do
  namespace :admin do
    get 'lists/index'
    get 'lists/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'lists/new'
    get 'lists/index'
    get 'lists/show'
  end
  namespace :public do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
