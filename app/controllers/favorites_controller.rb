class FavoritesController < ApplicationController
  prepend_before_action :signed_in?
  before_action :correct_user, only: :destroy

  def create
    # byebug
    @favorite = current_user.favorites.new(post_id: params[:post_id])
    if @favorite.save
      logger.info("post(id:#{@favorite.post_id})のお気に入り登録に成功しました。")
    else
      logger.info("post(id:#{@favorite.try(:post_id)})のお気に入り失敗しました。")
    end
  end

  def destroy
    @favorite = Favorite.find_by(post_id: params[:post_id], user_id: params[:id])
    if @favorite.destroy
      logger.info("post(id:#{@favorite.post_id})のお気に入り削除に成功しました。")
    else
      logger.info("post(id:#{@favorite.try(:post_id)})のお気に入り削除に失敗しました。")
    end
  end

  private

  def correct_user
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: params[:id])
    unless favorite.user == current_user
      redirect_back(fallback_location: root_path)
    end
  end

  def signed_in?
    redirect_to new_user_session_path unless user_signed_in?
  end
end
