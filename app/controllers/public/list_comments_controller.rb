class Public::ListCommentsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    comment = current_user.list_comments.new(list_comment_params)
    comment.list_id = list.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    ListComment.find_by(id: params[:id], list_id: params[:list_id]).destroy
    redirect_to request.referer
  end

  private
  def list_comment_params
    params.require(:list_comment).permit(:comment)
  end
end
