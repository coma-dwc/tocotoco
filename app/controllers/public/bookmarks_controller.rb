class Public::BookmarksController < ApplicationController

  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.new(article_id: @article.id)
    @bookmark.save!
  end

  def destroy
    @user = current_user
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.find_by(article_id: @article.id)
    @bookmark.destroy!
  end


end