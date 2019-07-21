class AreasController < ApplicationController
  def show
    @search_params = params.slice(:word)
    @area = Area.find(params[:id])

    @posts = Post.where(area_id: @area.id).user_search(@search_params)
    @popular_posts = Post.popular_area_posts(@area.id)
  end
end
