class UsersController < ApplicationController
  before_action :get_user
  
  def index
    users = User.all
    render json: users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: {errors: "Unable to create users"} 
    end
  end

  def show
    if @user.present?
      render json: @user
    else
      render json: {errors: "user is not found"}
    end
  end
  
  private

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_digest)
  end

end

