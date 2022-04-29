class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :post

  def user
    User.find_by(id: user_id)
  end
end
