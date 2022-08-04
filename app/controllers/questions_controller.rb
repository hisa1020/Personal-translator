class QuestionsController < ApplicationController
  before_action :set_question, only: %i(show edit update destroy)

  def index
    @questions = Question.all.order(updated_at: :DESC)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "質問の投稿が完了しました。"
      redirect_to question_path(@question.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @q_comments = @question.q_comments
    @q_comment = QComment.new
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:notice] = "質問内容を更新しました。"
      redirect_to question_path(@question.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = "質問を削除しました。"
    redirect_to questions_path, status: :see_other
  end
end

private

def question_params
  params.require(:question).permit(:q_title, :q_content, :user_id)
end

def set_question
  @question = Question.find(params[:id])
end
