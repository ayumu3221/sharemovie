class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  #before_action :ensure_guest_user, only: [:edit]
  


  def show
    @user = User.find(params[:id])
    @lists = @user.lists
    @list = List.new
  end

  def index
    @users = User.all
    @list = List.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:list_id)
    @favorite_lists = List.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end