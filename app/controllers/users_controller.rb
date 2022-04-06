class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:name, :introduction, :user_icon))
      flash[:notice]="プロフィールの更新に成功しました。"
      redirect_to users_profile_path
    else
      flash[:notice]="プロフィールの更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end
end
