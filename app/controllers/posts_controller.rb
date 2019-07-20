class PostsController < ApplicationController
  after_action :pageview_countup, only: %w(show)
  impressionist :actions=> [:show]
  ITEMS_PER_PAGE = 6

  
  def index
    # byebug
    @search_params = params.fetch(:post,{})
                            .permit(:word, {tag_ids:[]} )
    @areas = Area.all
    @featured_posts = FeaturedPost.order(:sortrank).limit(6).map(&:post)
    @posts = Post.user_search(@search_params).limit(5)
    @popular_posts = Post.popular_posts
    @tags = Tag.all
    @selected_tags = Tag.where(id: @search_params[:tag_ids])
  end

  def show
    @post = Post.find(params[:id])
    impressionist(@post, nil, unique: [:session_hash])
  end

  private

  def pageview_countup
    RedisService.countup @post.id
  end
end
