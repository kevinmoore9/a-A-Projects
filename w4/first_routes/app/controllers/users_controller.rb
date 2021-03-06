class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render (
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    ###############
    ###############
    ##############
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end


end
