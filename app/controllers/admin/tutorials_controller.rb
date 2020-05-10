class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)

    if tutorial.save
      conn = Faraday.new(url: 'https://www.googleapis.com') do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.params[:key] = ENV['YOUTUBE_API_KEY']
      end
      response = conn.get("/youtube/v3/playlistItems?part=snippet&playlistId=#{tutorial.youtube_id}&key=#{ENV['YOUTUBE_API_KEY']}&maxResults=50")
      @videos = JSON.parse(response.body, symbolize_names: true)
      mapped_videos = @videos[:items].map do |video|
        video = tutorial.videos.create!(title: video[:snippet][:title],
                                        description: video[:snippet][:description],
                                        thumbnail: video[:snippet][:thumbnails][:high][:url],
                                        video_id: video[:snippet][:resourceId][:videoId]
                                        )
        end

      flash[:success] = %Q[Successfully created tutorial! <a href="/tutorials/#{tutorial.id}">View it here</a>]
      flash[:html_safe] = true
      redirect_to "/admin/dashboard"

    else
      flash[:error] = "Tutorial was unable to be created"
      render :new
    end



  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:youtube_id, :title, :description, :thumbnail)
  end
end
