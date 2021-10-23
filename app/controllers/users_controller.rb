class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @user = User.all
    render json: @user
  end

  def show
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.search(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)

  end    
end