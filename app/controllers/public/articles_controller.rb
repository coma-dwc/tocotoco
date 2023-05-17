class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, except: [:show, :index]

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

  def tag_articles
    @tag = Hashtag.find_by(hashname: params[:name])
    @articles = @tag.articles
    if params[:name].nil?
      @tags = Hashtag.all.to_a.group_by{ |tag| tag.articles.count}
    else
      name = params[:name]
      name = name.downcase
      @tag = Hashtag.find_by(hashname: name)
      @article = @tag.articles
      @tags = Hashtag.all.to_a.group_by{ |tag| tag.articles.count}
    end
  end

  def index
    # @articles = Article.all.page(params[:page]).per(12)
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @tags =  @article.hashtags
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

  def bookmark
  @bookmarks = Bookmark.where(user_id: current_user.id)
  @bookmarks = @bookmarks.page(params[:page]).per(12)
  end



  private

  def article_params
    params.require(:article).permit(:title, :content, :user_id, :place_id, :hashtags, :address,  images: [] ) #写真複数投稿　配列形式で記述
  end

  def ensure_correct_user
    @article = Article.find(params[:id])
    if @article.user != current_user
      redirect_to article_path
    end
  end

  def ensure_guest_user
  redirect_to root_path unless current_user && current_user.is_not_guest?
  end


end
