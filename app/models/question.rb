class Question < ApplicationRecord
  validates :q_title, presence: true
  validates :q_content, presence: true
  belongs_to :user
end
