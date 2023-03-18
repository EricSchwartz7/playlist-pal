class Api::V1::UsersController < ApplicationController

  def index
    if current_user
      redirect_to '/api/v1/users/authorize_me'
    else
      render html: "<a href='api/v1/users/authorize_me'>Authorize Me</a>".html_safe
    end
  end

  def authorized
    if params[:error]
      render json: { error: params[:error] }
    elsif params[:state].blank?
      render json: { error: 'state_mismatch' }
    else
      if current_user
        render html: "
          <h1>#{current_user.name}</h1>
          <img src='#{current_user.image_url}' /><br/>
          <a href='/api/v1/tracks/hump_tracks'>Hump tracks</a><br/>
          <a href='/api/v1/tracks/names_only'>Names only</a>
        ".html_safe
      else
        refresh_token = User.get_refresh_token(params[:code])
        user = User.init(refresh_token)

        # Set current user
        session[:current_user_id] = user.id

        render html: "
          <h1><a href=#{user.url}>#{user.name}</a></h1>
          <img src=#{user.image_url} />
        ".html_safe
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
      redirect_uri: 'http://localhost:3000/api/v1/users/authorized',
      state: state
    }.to_query
    authorize_url = "https://accounts.spotify.com/authorize?#{query_params}"
    redirect_to authorize_url, allow_other_host: true
  end

end
