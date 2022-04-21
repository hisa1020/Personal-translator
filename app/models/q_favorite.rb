class QFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def question
    Question.find_by(id: question_id)
  end
end
