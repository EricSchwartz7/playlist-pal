class Track < ApplicationRecord

  def self.all_tracks
    response = HTTParty.get('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY')
    response.body if response.code == 200
  end

end
