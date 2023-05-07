Rails.application.routes.draw do
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ユーザー用ゲストログイン
  devise_scope :user do
    post 'users/guest_session', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root to: 'users#index'
    resources :articles
    resources :places, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :users, only: [:edit, :update, :unsubscribe, :destroy]
    get '/users/my_page' => 'users#show'
    get '/users/unsubscribe' => 'users#unsubscribe'
    get '/users/bookmark' => 'users#bookmark'
    resources :articles
    resource :bookmarks, only: [:create, :destroy]
    get '/post/hashtag/:name' => 'articles#hashtag'
    resources :comments, only: [:create, :destroy]
    resources :todos, only: [:new, :index, :create, :edit, :update, :destroy]
  end
end