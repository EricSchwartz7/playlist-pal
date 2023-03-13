class User < ApplicationRecord

  def self.get_refresh_token(code)
    auth_options = {
      body: {
        code: code,
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
    end
  end

  def self.refresh(refresh_token)
    auth_options = {
      body: {
        grant_type: 'refresh_token',
        refresh_token: refresh_token
      },
      headers: {
        'Authorization': "Basic #{Base64.strict_encode64("#{ENV.fetch('CLIENT_ID')}:#{ENV.fetch('CLIENT_SECRET')}")}"
      },
      json: true
    }
    response = HTTParty.post("https://accounts.spotify.com/api/token", auth_options)
    if !response['error'] && response.code == 200
      # puts "\n\n refresh: #{response.body} \n\n"
      access_token = response['access_token']
      expires_at = Time.now + response['expires_in']

      puts "\n\n new token expires at #{expires_at} \n\n"

      access_token

      # Update the access_token and expires_at for current user
    end
  end
end
