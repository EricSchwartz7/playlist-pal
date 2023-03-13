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
    # puts "\n\n get_refresh_token: #{response} \n\n"
    if response["error"].present?
      raise response["error_description"]
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
    # puts "\n\n refresh: #{response.body} \n\n"
    if !response['error'] && response.code == 200
      access_token = response['access_token']
      expires_at = Time.now + response['expires_in']
      [access_token, expires_at]
    end
  end

  def self.init(refresh_token)
    access_token, expires_at = User.refresh(refresh_token)
    user_data = HTTParty.get("https://api.spotify.com/v1/me", headers: { 'Authorization': "Bearer #{access_token}" })
    # puts "\n\n #{user_data} \n\n"
    user = User.find_or_initialize_by(spotify_id: user_data['id'])

    # Might as well update all user data on each login
    user.refresh_token = refresh_token
    user.access_token = access_token
    user.expires_at = expires_at
    user.name = user_data['display_name']
    user.url = user_data['href']
    user.image_url = user_data['images']&.first.dig('url')
    user.save!
    user
  end

  def refresh!
    access_token, expires_at = self.refresh(refresh_token)
    self.update!({
      access_token: access_token,
      expires_at: expires_at
    })

    access_token
  end

  def token_expired?
    self.expires_at < Time.now
  end
end
