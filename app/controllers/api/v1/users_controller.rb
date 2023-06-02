class Api::V1::UsersController < ApplicationController

  def index
    # puts "\n\n current user: #{current_user.inspect} \n\n"
    # if current_user
    #   redirect_to '/api/v1/users/authorize_me'
    # else
      render html: "<a href='api/v1/users/authorize_me'>Authorize Me</a>".html_safe
    # end
  end

  def authorized
    if params[:error]
      render json: { error: params[:error] }
    elsif params[:state].blank?
      render json: { error: 'state_mismatch' }
    else
      # if current_user
      #   render json: { success: true }
      # else
        refresh_token = User.get_refresh_token(params[:code])
        user = User.init(refresh_token)

        # Set current user
        session[:current_user_id] = user.id

        @_current_user ||= user.id &&
          User.find_by(id: user.id)

        render json: { user: user }
      # end
    end
  end

  def authorize_me
    state = SecureRandom.hex
    scope = 'playlist-read-private playlist-modify-private user-read-private user-read-email'

    query_params = {
      response_type: 'code',
      client_id: ENV.fetch('CLIENT_ID'),
      scope: scope,
      # redirect_uri: 'http://localhost:3000/api/v1/users/authorized',
      redirect_uri: 'http://localhost:4000/home',
      state: state
    }.to_query
    authorize_url = "https://accounts.spotify.com/authorize?#{query_params}"
    redirect_to authorize_url, allow_other_host: true
  end

end
