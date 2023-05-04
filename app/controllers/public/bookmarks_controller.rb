class Public::BookmarksController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    bookmark = article.bookmarks.build(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    article = current_user.articles.find(params[:article_id])
    bookmark = article.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

end
