class Api::V1::TracksController < ApplicationController

  def hump_tracks
    hump_tracks = Track.hump_tracks(current_user)
    render json: hump_tracks
  end

end
