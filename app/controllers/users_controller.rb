class UsersController < ApplicationController
  before_action :set_user, expect: %i(show)

  def show
    @user = User.find(params[:id])
  end

  def profile
  end

  def profile_edit
  end

  def update
    if @user.update(params.require(:user).permit(:name, :introduction, :user_icon))
      flash[:notice] = "プロフィールの更新に成功しました。"
      redirect_to users_profile_path
    else
      render :profile_edit, status: :unprocessable_entity
    end
  end

  def posts
  end

  def questions
  end

  def favorite_posts
  end

  def favorite_questions
  end
end

private

def set_user
  @user = current_user
end
