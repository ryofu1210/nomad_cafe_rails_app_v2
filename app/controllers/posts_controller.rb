class PostsController < ApplicationController
  before_action :search_params, only: %w(index area_index)
  after_action :pageview_countup, only: %w(show)
  impressionist :actions=> [:show]
  ITEMS_PER_PAGE = 6

  def index
    # add_breadcrumb 'Home', root_path
    # add_breadcrumb 'カフェ一覧', posts_path
    common_index
  end

  def area_index
    @area = Area.find(params[:id])

    common_index
    render action: :index
  end

  def show
    @post = Post.find(params[:id])
    impressionist(@post, nil, unique: [:session_hash])
  end

  private

  def pageview_countup
    RedisService.countup @post.id
  end

  def search_params
    @search_params = params.fetch(:post,{})
                            .permit(:word, {tag_ids:[]} )
  end

  def common_index
    @current_path = request.fullpath
    @areas = Area.all
    @featured_posts = FeaturedPost.order(:sortrank).limit(6).map(&:post)
    @posts = Post.user_search(@search_params).limit(5)
    @popular_posts = Post.popular_posts
    @tags = Tag.all
    @selected_tags = Tag.where(id: @search_params[:tag_ids])
  end
end
