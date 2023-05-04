class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @articles = current_user.articles.page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if user.update(user_params)
       redirect_to admin_user_path(@user.id)
    else
       render :show
    end
  end

  def destroy
  end

private

def user_params
  params.require(:user).permit(:name, :introduction, :image, :email, :is_deleted, :todo_id)
end

end
