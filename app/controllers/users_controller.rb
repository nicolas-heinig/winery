class UsersController < ApplicationController
  before_action :authorize_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User angelegt!'
    else
      render :new
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.save
      redirect_to users_path, notice: 'User gespeichert!'
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by_id(params[:id])

    user.destroy

    redirect_to users_path, notice: 'User gelöscht!'
  end

  private

  def user_params
    new_params = params.require(:user).permit(:username, :email, :role, :password)

    new_params[:role] = new_params[:role].to_i

    new_params
  end
end
