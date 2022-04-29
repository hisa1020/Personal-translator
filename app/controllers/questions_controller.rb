class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(updated_at: :DESC)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params.require(:question).permit(:q_title, :q_content, :user_id))
    if @question.save
      flash[:notice] = "質問の投稿が完了しました。"
      redirect_to question_path(@question.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(params.require(:question).permit(:q_title, :q_content, :user_id))
      flash[:notice] = "質問内容を更新しました。"
      redirect_to question_path(@question.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "質問を削除しました。"
    redirect_to questions_path, status: :see_other
  end
end
