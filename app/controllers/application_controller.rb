class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveHash::RecordNotFound, with: :render_404
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    # set_view_path
    render template: 'errors/error_404', status: 404
  end


end
