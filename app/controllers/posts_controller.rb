class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update destroy)

  def index
    @posts = Post.all.order(updated_at: :DESC)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to post_path(@post.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿内容を更新しました。"
      redirect_to post_path(@post.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path, status: :see_other
  end
end

private

def post_params
  params.require(:post).permit(:title, :artist, :content, :user_id)
end

def set_post
  @post = Post.find(params[:id])
end
