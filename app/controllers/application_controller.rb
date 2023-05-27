class ApplicationController < ActionController::API
  private

  def current_user
    # @_current_user ||= session[:current_user_id] &&
    #   User.find_by(id: session[:current_user_id])

    @_current_user = User.first
  end
end
