class Public::UsersController < ApplicationController
  # before_action :authenticate_user!
   before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
    @articles = @user.articles.page(params[:page]).per(6)
  end

  def edit
    @user = current_user
  end

  def update
     @user = current_user
     if @user.update(user_params)
        redirect_to  users_my_page_path
     else
        redirect_to  users_my_page_path
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
    params.require(:user).permit(:name, :introduction, :image, :email, :is_deleted, :todo_id, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
