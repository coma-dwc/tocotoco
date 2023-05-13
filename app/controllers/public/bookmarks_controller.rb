class Public::BookmarksController < ApplicationController

  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.new(article_id: @article.id)
    @bookmark.save!
    # redirect_back(fallback_location: root_path) #リダイレクト先を削除することでjavascriptリクエストとなり、createアクション実行後はcreate.js.erbファイルを探すようになる
  end

  def destroy
    @user = current_user
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.find_by(article_id: @article.id)
    @bookmark.destroy!
    # redirect_back(fallback_location: root_path)   #リダイレクト先を削除することでjavascriptリクエストとなり、destroyアクション実行後はdestroy.js.erbファイルを探すようになる
  end


end