class QFavoritesController < ApplicationController
  def create
    @question_favorite = QFavorite.new(user_id: current_user.id, question_id: params[:question_id])
    @question_favorite.save
    redirect_to question_path(params[:question_id]), status: :see_other
  end

  def destroy
    @question_favorite = QFavorite.
      find_by(user_id: current_user.id, question_id: params[:question_id])
    @question_favorite.destroy
    redirect_to question_path(params[:question_id]), status: :see_other
  end
end
