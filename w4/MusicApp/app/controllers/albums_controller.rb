class AlbumsController < ApplicationController

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = ["Album creation unsuccessful"]
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def edit

  end

  def destroy

  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :year, :live)
  end
end
