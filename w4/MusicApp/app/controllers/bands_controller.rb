class BandsController < ApplicationController

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = ["Band creation unsuccessful"]
      render :new
    end
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  def edit

  end

  def destoy

  end


  private

  def band_params
    params.require(:band).permit(:name)
  end
end
