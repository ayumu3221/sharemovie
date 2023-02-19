class Public::FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end
  
  def create
    list = LIst.find(params[:list_id])
    @favorite = current_user.favorites.new(list_id: list.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    list = LIst.find(params[:list_id])
    @favorite = current_user.favorites.find_by(list_id: list.id)
    @favorite.destroy
    render 'replace_btn'
  end
  
end

