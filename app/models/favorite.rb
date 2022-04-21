class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def post
    Post.find_by(id: post_id)
  end
end
