class Track < ApplicationRecord

  def self.hump_tracks(access_token)
    url = "https://api.spotify.com/v1/playlists/1iEBIGcyYV9C3biY60X1oi/tracks?fields=items(added_at,added_by.id,track(id,name,href,album(name,href,images(url)),artists(name, href)))&limit=50&offset=0"
    HTTParty.get(url, headers: { 'Authorization': "Bearer #{access_token}" })
  end

  def self.http_test
    response = HTTParty.get('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY')
    response.body if response.code == 200
  end

end
