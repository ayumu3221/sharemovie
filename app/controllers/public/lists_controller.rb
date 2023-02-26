class Public::ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @list = List.find(params[:id])
    @list_comment = ListComment.new
  end

  #過去一週間でいいねされた数
  def index
    to  = Time.current.at_beginning_of_day
    from  = (to - 6.day).at_end_of_day
    @lists = List.all.sort {|a,b| 
      b.favorites.where(created_at: from...to).size <=> 
      a.favorites.where(created_at: from...to).size
    }
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


  #他人の編集画面に遷移しない
  def ensure_correct_user
    @list = List.find(params[:id])
    unless @list.user == current_user
      redirect_to lists_path
    end
  end
end
