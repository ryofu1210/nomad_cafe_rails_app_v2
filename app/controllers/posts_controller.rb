class PostsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :search_params, only: %w[index area_index]
  after_action :pageview_countup, only: %w[show]
  impressionist actions: [:show]
  ITEMS_PER_PAGE = 3

  def index
    set_common_data
    @posts = Post.includes(:tags)
                  .user_search(@search_params)
                  .active
                  .page(params[:page])
                  .per(ITEMS_PER_PAGE)
    # byebug
    return render status: 404 if @posts.blank?
  end

  def area_index
    @area = Area.find(params[:id])

    set_common_data
    @posts = Post.includes(:tags)
                 .where(area_id: @area.id)
                 .user_search(@search_params)
                 .active
                 .page(params[:page])
                 .per(ITEMS_PER_PAGE)
    return render action: :index, status: 404 if @posts.blank?

    render action: :index
  end

  def sort; end

  def show
    @post = Post.active.find(params[:id])
    @tags = @post.tags
    @area = @post.area
    @items = @post.items.includes(:target)
    impressionist(@post, nil, unique: [:session_hash])
  end

  private

  def pageview_countup
    RedisService.countup @post.id
  end

  def search_params
    @search_params = params.fetch(:post, {})
                           .permit(:word, tag_ids: [])
                           .reject { |_k, v| v.blank? }
  end

  def set_common_data
    @current_path = request.fullpath
    @areas = Area.all
    @tags = Tag.all
    @selected_tags = Tag.where(id: @search_params[:tag_ids])
  end
end
