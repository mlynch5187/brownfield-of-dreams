class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def index
    if current_user != nil
      @show_tutorials = Tutorial.all
    else
      @show_tutorials = []
      tutorials = Tutorial.all
      tutorials.each do |tutorial|
        if tutorial.classroom == false
          @show_tutorials << tutorial
        end
      end
    end 
  end
end
