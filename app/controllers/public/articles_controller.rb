class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
     @article = Article.new(article_params)
     @article.user_id = current_user.id
    # @articles.place_id = @place.id #要確認
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

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @articles = @tag.articles.build
    @article  = @tag.articles.page(params[:page])
    @comment    = Comment.new
    @comments   = @articles.comments
  end


  private

  def article_params
    params.require(:article).permit(:title, :content, :user_id, :place_id, :hashtags, image: [] ) #写真複数投稿　配列形式で記述
  end

end
