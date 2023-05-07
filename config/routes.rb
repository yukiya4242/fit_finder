Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)     #adminに必要なルーティングは全て自動生成
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


  resources :chats, only:[:show, :create]



  resources :users  do #usersリソースのルーティングを開始と終了のブロック
    member do
      get    :chat_history
      get    :following, :followers
      post   :follow
      delete :unfollow
      delete "/users/:id/hide" => "users#hide", as: 'users_hide'
    end
    collection do
      get    :search
    end


   end

end
