class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @search_params = params.slice(:word)
    @areas = Area.all
    # byebug
    @featured_posts = FeaturedPost.includes(:post)
                                  .order(:sortrank)
                                  .select { |fp| fp.post.accepted? }
                                  .map(&:post)
                                  .take(6)
    # byebug
    @posts = Post.active.limit(6)
    @popular_posts = Post.popular_posts.active.limit(6)
  end

  def health_check
    render plain:"ok", status: :ok
  end
end
