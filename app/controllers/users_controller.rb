class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new create_user_params
    if @user.save
      redirect_to root_path, notice: "You have successfully add #{@user.email}"
    else
      render :new
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:email)
  end
end
