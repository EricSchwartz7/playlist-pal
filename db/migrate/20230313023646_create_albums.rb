class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
