class FavoritesController < ApplicationController
  prepend_before_action :signed_in?
  before_action :correct_user, only: :destroy

  def create
    # byebug
    @favorite = current_user.favorites.new(post_id: params[:post_id])
    if @favorite.save
      # flash[:notice] = "お気に入り登録が完了しました。"
      # redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'お気に入り登録が失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @favorite = Favorite.find_by(post_id: params[:post_id], user_id: params[:id])
    @favorite.destroy
    # flash[:notice] = "お気に入りから外しました。"
    # redirect_back(fallback_location: root_path)
  end

  private

  def correct_user
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: params[:id])
    unless favorite.user == current_user
      flash[:alert] = '権限がありません'
      redirect_back(fallback_location: root_path)
    end
  end

  def signed_in?
    redirect_to new_user_session_path unless user_signed_in?
  end
end
