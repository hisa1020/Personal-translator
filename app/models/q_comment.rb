class QComment < ApplicationRecord
  validates :q_content, presence: true
  belongs_to :user
  belongs_to :question

  def user
    User.find_by(id: user_id)
  end
end
