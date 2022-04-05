class User < ApplicationRecord
  validates :name,presence:true, on: :update
  validates :introduction,presence:true, on: :update

  mount_uploader :user_icon, UserIconUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
