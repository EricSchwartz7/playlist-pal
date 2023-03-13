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
      auth_options = {
        body: {
          code: params[:code],
          redirect_uri: 'http://localhost:3000/api/v1/tracks/authorized',
          grant_type: 'authorization_code'
        },
        headers: {
          'Authorization': "Basic #{Base64.strict_encode64("#{ENV.fetch('CLIENT_ID')}:#{ENV.fetch('CLIENT_SECRET')}")}"
        },
        json: true
      }
      response = HTTParty.post("https://accounts.spotify.com/api/token", auth_options)
      # puts "\n\n #{response} \n\n"
      if response["error"].present?
        render json: response
      else
        refresh_token = response['refresh_token']
        access_token = User.refresh(refresh_token)
        render json: { access_token: access_token }
      end
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
