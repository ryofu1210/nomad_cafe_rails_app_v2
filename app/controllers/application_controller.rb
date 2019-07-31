class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveHash::RecordNotFound, with: :render_404

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = '権限がありません。'
    redirect_to root_path
  end

  def render_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    # set_view_path
    render template: 'errors/error_404', status: 404
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def health_check
    render text:  'ok', status: :ok
  end
end
