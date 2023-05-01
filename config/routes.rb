Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)     #adminに必要なルーティングは全て自動生成
  root to:  'homes#top'
  get 'homes/about' => 'homes#about'
  
  devise_for :users, controllers: {
    session: 'users/sessions'
  }
  
  devise_scope :user do
    post 'users_guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :posts do
    resources :comments, only:[:create, :destroy]
    resource  :likes,    only:[:create, :destroy] #[resouce]単数系だと/:idが含まれなくなる
  end


  resources :messages, only:[:index, :show, :create]


  resources :users,    only:[:index, :show, :edit, :update] do #usersリソースのルーティングを開始と終了のブロック
    member do
      get    :following, :followers
      post   :follow
      delete :unfollow
    end
    collection do
      get    :search
    end
     end

end
