Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to:  'homes#top'
  get 'homes/about' => 'homes#about'


  devise_for :users, controllers: {
    session:       'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users_guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :posts do
    resources :comments, only:[:create, :destroy]
    resources  :likes,    only:[:create, :destroy] #[resouce]単数系だと/:idが含まれなくなる
  end


  resources :chats, only:[:show, :create, :destroy] do
    member do
      patch :read
    end
  end

  resources :relationships, only:[:create]
  resources :notifications, only:[:index, :update]
  resources :rooms, only:[:show]
  resources :saved_files, only:[:create]



  resources :users  do #usersリソースのルーティングを開始と終了のブロック
    member do
      get    :liked_posts
      get    :chat_history
      get    :following, :followers
      post   :follow
      delete :unfollow
      delete :hide, as: 'users_hide'
    end
    collection do
      get    :search
    end


   end

end
