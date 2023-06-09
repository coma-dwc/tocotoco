class Public::UsersController < ApplicationController
   before_action :ensure_guest_user, only: [:edit]
   before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(6)
  end

  def my_page
    @user = current_user
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(6)
    render :show
  end

  def edit
    @user = current_user
  end

  def update
     @user = current_user
     if @user.update(user_params)
        redirect_to  user_my_page_path
     else
        render :edit
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
      flash[:messege] = "退会処理を行いました。今までご利用いただきありがとうございました。"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image, :email, :is_deleted, :todo_id, :profile_image)
  end

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to user_my_page_path , notice: '他のユーザーのプロフィール編集画面へは遷移できません。'
    end
  end

end
