class Admin::PlaylistsController < Admin::BaseController

  def new
    @tutorial = Tutorial.new
  end

  def create
    # playlist = Playlist.find(params[:playlist_id])
    # tutorial = Tutorial.new()
  end
end
