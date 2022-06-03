Rails.application.routes.draw do
  #ユーザー側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  #管理者側
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  #ユーザー側
  scope module: :public do
    root to: 'homes#top'
    
    resources :users, only: [:show, :edit, :update] do
      member do
        get :favorites
      end
    end
    get 'users/quit', as: 'quit'
    patch 'users/withdraw', as: 'withdraw'
    
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    
    get 'search' => 'searches#search'
  end
  
  #管理者側
  namespace :admin do
    resources :posts, only: [:index, :show] do
      resources :post_comments, only: [:destroy]
    end
    
    resources :users, only: [:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
