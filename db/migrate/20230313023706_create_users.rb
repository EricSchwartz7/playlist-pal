class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :spotify_id
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
