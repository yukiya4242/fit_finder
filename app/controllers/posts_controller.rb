class PostsController < ApplicationController
  before_action :authenticate_user!, expect:[:index, :show, :new]
  before_action :check_guest_user,   only:[:edit, :update, :destroy]
  before_action :logged_in_user,     only:[:edit]
  before_action :correct_user,       only:[:update, :destoy, :edit]

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.build(post_params) #投稿データをDBに保存
    if @post.save
      flash[:success] = '投稿が完了しました'
    redirect_to posts_path
    else
      flash[:danger] = '投稿に失敗しました。もう一度お試しください'
    redirect_to posts_path
    end
  end

  def index
    @user = current_user #現在のユーザー
    @posts = Post.all #投稿情報を全て取得
    @posts = Post.order(created_at: :desc) #取得した投稿を降順（新しい順）に並び替える
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id]) #対象の投稿を見つける
    if @post.update(post_params) #投稿を更新したら
    redirect_to post_path(@post) #その投稿の詳細ページにリダイレクト
    else
    render :edit
    end
  end

  def show
  @post = Post.find_by(id: params[:id])
  @comments = @post.comments.order(created_at: :desc)
  if @post.nil?
    redirect_to posts_path
  else
    @comment = Comment.new
  end
  end



  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  private

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to(user_path(current_user), alert: '不正なアクセスです') if @post.nil?
  end

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "ログインしてください"
      redirect_to new_user_session_path, status: :see_other
    end
  end

  def post_params
  params.require(:post).permit(:content, :image, :video)
  end


  def check_guest_user
    if current_user.email == 'guest@exmple.com'
      redirect_to root_path, alert: 'ゲストユーザーは編集できません'
    end
  end
end