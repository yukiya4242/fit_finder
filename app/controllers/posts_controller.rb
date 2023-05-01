class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
    redirect_to posts_path(@post.id)
    else
    render :new
    end

  def index
    @posts = Posts.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post_id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

end
