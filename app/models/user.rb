class User < ApplicationRecord
  validates :name, presence: true, length: { in: 3..12 }
  validates :introduction, presence: true, length: { in: 10..30 }, on: :update

  mount_uploader :user_icon, UserIconUploader

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
