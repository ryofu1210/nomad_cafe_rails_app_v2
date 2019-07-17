class Api::PostsController < ApplicationController
  before_action :set_post, only: %w(update)

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
    @post = Post.new(user_id: 1)
    if @post.save_all(post_params)
      head :no_content
    else
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
      }
  
      @items = Item.where(post_id: @post.id).order(:sortrank)
  
      @items_params = @items.map {|item|
        item_default_params = {
          id: item.id,
          post_id: item.post_id,
          sortrank: item.sortrank,
          target_type: item.target_type,
          target_id: item.target_id
        }
        case item.target_type
        when "ItemHeading" then
          item_default_params.merge({title: item.target.title})
        when "ItemText" then
          item_default_params.merge({body: item.target.body})
        when "ItemImage" then
          item_default_params.merge({image: item.target.image.url})
        end
      }
      # logger.debug(@items_params)
    end

    def set_post
      @post = Post.includes(items: :target).find(params[:id])
      # byebug
    end

    def post_params
      logger.debug("#{params}")
      # logger.debug("#{params.require(:post)}")
      # byebug

      params.require(:post).permit(
          :name,
          :description,
          # {image: :url},
          :image,
          :status,

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
          ]
        )
    end
end
