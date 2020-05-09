class AddYoutubeIdToTutorials < ActiveRecord::Migration[5.2]
  def change
    add_column :tutorials, :youtube_id, :string
  end
end
