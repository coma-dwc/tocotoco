class Public::UsersController < ApplicationController
  # before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
     @user = current_user
     if @user.update(user_params)
        redirect_to user_path
     else
        redirect_toedit_usert_path
     end
  end

  def unsubscribe
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.update(is_deleted: true)
    if @user.save
      reset_session
      flash[:messege] = "ありがとうございました。またのご利用を心よりお待ちしています。"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image, :email, :is_deleted, :todo_id)
  end

end
