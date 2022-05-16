class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params.require(:comment).permit(:rate, :content, :post_id))
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to post_path(@comment.post_id)
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      redirect_to post_path(@comment.post_id)
    end
  end
end
