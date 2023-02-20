class Public::ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @list = List.find(params[:id])
    @comment = Comment.new
  end

  def index
    @lists = List.all
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to list_path(@list), notice: "You have created movie successfully."
    else
      @lists = List.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(@list), notice: "You have updated movie successfully."
    else
      render "edit"
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :body)
  end

  def ensure_correct_user
    @list = List.find(params[:id])
    unless @list.user == current_user
      redirect_to lists_path
    end
  end
end
