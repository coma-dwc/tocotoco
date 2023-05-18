class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :place_id, :hashtags, images: [] )
  end

end
