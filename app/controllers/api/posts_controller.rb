class Api::PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: %w[update update_status]

  def edit
    @post = Post.find(params[:id])
    set_store
  end

  def new
    @post = Post.new
    set_store
  end

  def update
    # byebug
    if @post.save_all(post_params)
      head :no_content
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    @post = Post.new(user_id: current_user.id)
    # byebug
    if @post.save_all(post_params)
      head :no_content
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_status
    if @post.update(post_params)
      flash[:notice] = '投稿の公開状況が更新されました。'
      head :no_content
    else
      flash[:alert] = '投稿の公開状況の更新に失敗しました。'
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_store
    @post_params = {
      id: @post.id,
      name: @post.name,
      description: @post.description,
      image: @post.image.url,
      status: @post.status,
      area_id: @post.area_id,
      tag_ids: @post.tag_ids
    }

    @items = Item.where(post_id: @post.id).order(:sortrank)
    @items_params = @items.map do |item|
      item_default_params = {
        id: item.id,
        post_id: item.post_id,
        sortrank: item.sortrank,
        target_type: item.target_type,
        target_id: item.target_id
      }
      case item.target_type
      when 'ItemHeading'
        item_default_params.merge(title: item.target.title)
      when 'ItemText'
        item_default_params.merge(body: item.target.body)
      when 'ItemImage'
        item_default_params.merge(image: item.target.image.url)
      end
    end

    @areas_params = Area.all.map do |area|
      area_params = {
        id: area.id,
        name: area.name
      }
    end

    @tags_params = Tag.all.map do |tag|
      tag_params = {
        id: tag.id,
        name: tag.name
      }
    end
    logger.debug(@areas_params)
    # logger.debug(@items_params)
  end

  def set_post
    @post = Post.includes(items: :target).find(params[:id])
    # byebug
  end

  def post_params
    logger.debug(params.to_s)
    # logger.debug("#{params.require(:post)}")
    # byebug

    params.require(:post).permit(
      :name,
      :description,
      # {image: :url},
      :image,
      :status,
      :area_id,
      tag_ids: [],
      # post_tags_attributes: [
      #   :tag_id, 
      #   :post_id
      # ],
      items_attributes: [
        :id,
        :post_id,
        :sortrank,
        :target_type,
        :target_id,
        :title,
        :body,
        # {image: :url}
        :image
      ],
    )
  end
end
