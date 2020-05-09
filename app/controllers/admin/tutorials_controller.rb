class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)

    if tutorial.save
      conn = Faraday.new(url: 'https://www.googleapis.com/youtube/v3') do |faraday|
        faraday.headers['Authorization'] = "AIzaSyBcqY7dl4wa7xVsAY2qta2u_Ffnz4M0u7o"
        faraday.headers['Accept'] = "application/json"
      end
      response = conn.get("/playlistItems?part=snippet&playlistId=PLxhnpe8pN3TkenzFLTlz2hUd6_BZu-5Zv&key=AIzaSyBcqY7dl4wa7xVsAY2qta2u_Ffnz4M0u7o")
      require "pry"; binding.pry
      redirect_to "/admin/dashboard"

    else
      flash[:error] = 'Did not Work'
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
