class PostsController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show]
  before_action :check_guest_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
    redirect_to posts_path
    else
    render :new
    end
  end

  def index
    @posts = Post.all
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
    flash[:alert] = "投稿が見つかりません"
    redirect_to posts_path
  else
    @comment = Comment.new
  end
end



  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to post_path
  end

  private

  def post_params
  params.require(:post).permit(:content, image: [])
  end


  def check_guest_user
    if current_user.email == 'guest@exmple.com'
      redirect_to root_path, alert: 'ゲストユーザーは編集できません'
    end
  end
end