class TracksController < ApplicationController

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = ["Track add unsuccessful"]
      render :new
    end
  end

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end


  def edit

  end

  def destroy

  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :ord, :bonus, :lyrics)
  end
end
