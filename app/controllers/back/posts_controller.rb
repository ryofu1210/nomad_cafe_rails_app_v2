class Back::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.update(state: 'deleted')
      flash[:notice] = "削除が完了しました。"
      redirect_to back_posts_path
    else
      flash[:alert] = "削除が失敗しました。"
      render action: :index
    end
  end
end
