Rails.application.routes.draw do
  root to:  'homes#top'
  get 'homes/about' => 'homes#about'
  devise_for :users

  resources :posts
  resources :comments, only:[:create, :destroy]
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
