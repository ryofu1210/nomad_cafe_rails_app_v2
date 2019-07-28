class Back::PostsController < ApplicationController
  load_and_authorize_resource
  ITEMS_PER_PAGE = 5

  def index
    @search_params = search_params
          
    # @posts = current_user.posts.includes(:user)
    @posts = Post.by_user_role(current_user)
                         .back_search(@search_params)
                         .page(params[:page])
                         .per(ITEMS_PER_PAGE)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    logger.debug('destroy!!')
    @post = Post.find(params[:id])
    if @post.update(status: :deleted)
      flash[:notice] = '削除が完了しました。'
      redirect_to back_posts_path
    else
      flash[:alert] = '削除が失敗しました。'
      render action: :index
    end
  end

  private

  def search_params
    # byebug
    search_params = params.fetch(:post, {})
                          .permit(:id, :name, :user_name, { status_ids: [] },
                                  :from, :to, :updated_at_order, :status_order)
    # .reject {|k,v| v.blank?}
    # byebug
    # 以前の検索条件がセッションに残っていれば引き継ぐ
    if session[:search_params]
      session[:search_params] = session[:search_params].merge(search_params)
      session[:search_params].delete('status_ids') if search_params[:status_ids].nil?
    else
      session[:search_params] = search_params
    end
    session[:search_params].reject { |_k, v| v.blank? }.try(:symbolize_keys).presence || {}
    # logger.debug(session[:search_params])
    # return session[:search_params]
  end

  def post_params; end
end
