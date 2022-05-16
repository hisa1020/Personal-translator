class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "投稿"
      @posts = Post.looks(params[:search], params[:word])
      flash[:notice] = "検索結果: #{@posts.count}件"
      render template: "posts/index"
    elsif @range == "質問"
      @questions = Question.looks(params[:search], params[:word])
      flash[:notice] = "検索結果: #{@questions.count}件"
      render template: "questions/index"
    else
      render "search"
    end
  end
end
