class Public::ListCommentsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    @comment = current_user.list_comments.new(list_comment_params)
    @comment.list_id = list.id
    @comment.save
  end

  def destroy
    @comment = ListComment.find_by(id: params[:id], list_id: params[:list_id])
    @comment.destroy
  end

  private
  def list_comment_params
    params.require(:list_comment).permit(:comment)
  end
end
