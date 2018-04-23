class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      redirect_to post_path(@post)
    else
      render new_post_path(@post)
    end
  end

  def edit
  end
  def update
    if @post.update!(post_params)
      flash[:notice] = '文章更新成功'
      redirect_to post_path(@post)
    else
      flash[:alert] = '更新失敗'
      render edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = '文章已刪除'
    redirect_to posts_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:content,:image,category_ids:[] )
  end

end
