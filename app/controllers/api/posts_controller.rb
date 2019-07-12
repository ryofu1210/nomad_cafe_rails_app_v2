class Api::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @items = Item.where(post_id: @post.id).order(:sortrank)

    item_params = @items.map {|item|
      item_default_params = {
      id: item.id,
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
        item_default_params.merge({image: item.target.image})
      end
    }
    
    render json: item_params
  end
end
