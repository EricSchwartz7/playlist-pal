class Api::V1::TracksController < ApplicationController
  def index
    render html: "<a href='api/v1/tracks/authorize_me'>Authorize Me</a>".html_safe
  end

  def authorized
    if params[:error]
      render json: { error: params[:error] }
    elsif params[:state].blank?
      render json: { error: 'state_mismatch' }
    else
      refresh_token = User.get_refresh_token(params[:code])
      user_info = User.init(refresh_token)
      # access_token = User.refresh(refresh_token)
      render json: user_info
      # render json: Track.hump_tracks(access_token)
    end
  end

  def authorize_me
    state = SecureRandom.hex
    scope = 'playlist-read-private playlist-modify-private user-read-private user-read-email'

    query_params = {
      response_type: 'code',
      client_id: ENV.fetch('CLIENT_ID'),
      scope: scope,
      redirect_uri: 'http://localhost:3000/api/v1/tracks/authorized',
      state: state
    }.to_query
    authorize_url = "https://accounts.spotify.com/authorize?#{query_params}"
    redirect_to authorize_url, allow_other_host: true
  end
end
