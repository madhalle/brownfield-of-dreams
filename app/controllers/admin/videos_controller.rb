class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      flash[:success] = 'Video Updated!'
      redirect_to tutorial_path(@video.tutorial_id)
    else
      flash[:error] = @video.errors.full_messages.to_sentence
      render :edit
    end
  end

  def create
    begin
      tutorial = Tutorial.find(params[:tutorial_id])
      thumbnail = YouTube::Video.by_id(video_params[:video_id]).thumbnail
      video = tutorial.videos.new(video_params.merge(thumbnail: thumbnail))

      video.save

      flash[:success] = 'Successfully created video.'
    rescue StandardError => e
      flash[:error] = e.to_s
    end

    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail, :position)
  end
end
