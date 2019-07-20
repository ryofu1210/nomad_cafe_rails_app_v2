class StaticPagesController < ApplicationController
  def home
    @search_params = params.slice(:word)
    @areas = Area.all
    @featured_posts = FeaturedPost.order(:sortrank).limit(6).map(&:post)
    @posts = Post.all.limit(5)
    @popular_posts = Post.popular_posts
  end
end
