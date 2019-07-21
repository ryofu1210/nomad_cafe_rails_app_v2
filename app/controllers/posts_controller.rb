class PostsController < ApplicationController
  before_action :search_params, only: %w(index area_index)
  after_action :pageview_countup, only: %w(show)
  impressionist :actions=> [:show]
  ITEMS_PER_PAGE = 3

  def index
    set_common_data
    @posts = Post.user_search(@search_params)
              .page(params[:page]).per(ITEMS_PER_PAGE)

  end

  def area_index
    set_common_data
    @area = Area.find(params[:id])
    @posts = Post.where(area_id: @area.id).user_search(@search_params)
              .page(params[:page]).per(ITEMS_PER_PAGE)

    render action: :index
  end

  def sort

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

  def set_common_data
    @current_path = request.fullpath
    @areas = Area.all                      
    @tags = Tag.all
    @selected_tags = Tag.where(id: @search_params[:tag_ids])
  end
end
