Rails.application.routes.draw do
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ユーザー用ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
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
    resources :comments, only: [:destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/user/my_page' => 'users#my_page'
    get '/user/unsubscribe' => 'users#unsubscribe'
    delete '/user/delete' => 'users#delete'
    resource :user, only: [:edit, :update, :destroy,:show]
    # get '/user/:id' => 'users#show'
     resources :users, only: [:show]
     get '/tags/:name' => 'articles#tag_articles', as: "tag"
    resources :articles do
      resource :bookmarks, only: [:create, :destroy]
      get '/bookmark' => 'articles#bookmark'
      resources :comments, only: [:create, :destroy]
    end

    resources :todos, only: [:new, :index, :create, :edit, :update, :destroy]
  end
end