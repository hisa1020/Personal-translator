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
      render action: :edit
    end
  end
end
