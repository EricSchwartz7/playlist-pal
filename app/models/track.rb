class Track < ApplicationRecord

  def self.all_tracks

  end

  def self.http_test
    response = HTTParty.get('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY')
    response.body if response.code == 200
  end

end
