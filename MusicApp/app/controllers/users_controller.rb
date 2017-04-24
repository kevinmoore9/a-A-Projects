class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to bands_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

    def show
      @user = User.find_by(id: params[:id])
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
