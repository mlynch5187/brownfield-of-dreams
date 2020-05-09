class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :youtube_id
      t.timestamps
    end
  end
end
