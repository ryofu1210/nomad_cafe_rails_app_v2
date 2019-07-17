class StaticPagesController < ApplicationController
  def home
    @featured_posts = FeaturedPost.order(:sortrank).limit(6)
  end
end
