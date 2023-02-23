class Public::CommentsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    @comment = current_user.comments.new(comment_params)
    @comment.list_id = list.id
    @comment.save
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], list_id: params[:list_id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end

