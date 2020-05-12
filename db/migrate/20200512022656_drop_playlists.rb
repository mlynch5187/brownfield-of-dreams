class DropPlaylists < ActiveRecord::Migration[5.2]
  def change
    drop_table :playlists
  end
end
