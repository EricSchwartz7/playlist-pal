class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :url
      t.text :notes
      t.datetime :added_at
      t.integer :user_id
      t.integer :album_id
      t.integer :theme_id

      t.timestamps
    end
  end
end
