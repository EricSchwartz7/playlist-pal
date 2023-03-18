class Api::V1::TracksController < ApplicationController
  before_action :refresh_user

  def hump_tracks
    hump_tracks = Track.hump_tracks(current_user)
    render json: hump_tracks
  end

  def names_only
    puts "\n\n #{params} \n\n"
    hump_tracks = Track.names_only(current_user, params[:page].to_i)
    render json: hump_tracks
  end

  private

  def refresh_user
    current_user.refresh
  end

end
