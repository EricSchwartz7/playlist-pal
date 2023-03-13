class CreateArtistTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :artist_tracks do |t|
      t.integer :track_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
