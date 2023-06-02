class ApplicationController < ActionController::API
  private

  def current_user
    @_current_user ||= User.find_by_id(params[:user])
  end
end
