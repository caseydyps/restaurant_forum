Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories, only: :show
  root "restaurants#index"

  # 將 :index 加入開放項目
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :friend
    end
  end

  resources :followships, only: [:create, :destroy]

  resources :friendships, only: [:create, :update, :destroy]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
   # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
       # 十大人氣餐廳
      get :ranking
    end

    # 瀏覽個別餐廳的 Dashboard
    member do
      get :dashboard
      post :favorite
      post :unfavorite
    end

    member do
      # 其他程式碼
      post :like
      post :unlike
    end



  end


end
