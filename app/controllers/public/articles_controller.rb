class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
     @article = Article.new(article_params)
     @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article.id)
    else
      render :new
    end
  end

  def index
    @articles = Article.all.page(params[:page]).per(12)
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
     @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article.id)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :user_id, :place_id, :hashtags, :image)
  end

end
