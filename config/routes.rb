Rails.application.routes.draw do
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root to: 'homes#top'
    resources :articles
    resources :places, only: [:index]
    resources :users
    resources :comments, only: [:create, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :users
    resources :articles
    resource :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :todos, only: [:index, :create, :destroy]
  end
end