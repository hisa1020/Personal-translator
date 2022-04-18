class QCommentsController < ApplicationController
  def create
    @q_comment = QComment.new(params.require(:q_comment).permit(:q_content, :question_id))
    @q_comment.user_id = current_user.id
    if @q_comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to post_path(@q_comment.question_id)
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      redirect_to post_path(@q_comment.question_id)
    end
  end
end
