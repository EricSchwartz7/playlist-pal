class Track < ApplicationRecord

  def self.hump_tracks(current_user)
    url = "https://api.spotify.com/v1/playlists/1iEBIGcyYV9C3biY60X1oi/tracks?fields=items(added_at,added_by.id,track(id,name,href,album(name,href,images(url)),artists(name, href)))&limit=50&offset=0"
    HTTParty.get(url, headers: { 'Authorization': "Bearer #{current_user.access_token}" })
  end

end
