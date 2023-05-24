class PostsController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show, :new]
  before_action :check_guest_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿が完了しました'
    redirect_to posts_path
    else
      flash[:danger] = '投稿に失敗しました。もう一度お試しください'
    redirect_to posts_path
    end
  end

  def index
    @user = current_user
    @posts = Post.all
    @posts = Post.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    puts "Updating post with params: #{post_params.inspect}"
    if @post.update(post_params)
    redirect_to post_path(@post)
    else
    render :edit
    end
  end

  def show
  @post = Post.find_by(id: params[:id])
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

  def post_params
  params.require(:post).permit(:content, :image, :video)
  end


  def check_guest_user
    if current_user.email == 'guest@exmple.com'
      redirect_to root_path, alert: 'ゲストユーザーは編集できません'
    end
  end
end