class User < ApplicationRecord
  validates :name, presence: true, length: { in: 3..12 }
  validates :introduction, presence: true, length: { in: 10..30 }, on: :update

  mount_uploader :user_icon, UserIconUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
