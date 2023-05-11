Bookmarks_controller.rb

class BookmarksController < ApplicationController

#   def create
#     @article = Article.find(params[:article_id])
# #Articleモデルからarticle_idを探してくる。
#     current_user.bookmark(@article)
# # ログイン中のユーザーと紐づけられたidを取ってくる
#   end

#   def destroy
#     @article = current_user.bookmarks.find(params[:article_id]).article
#     current_user.unbookmark(@article)
#     # redirect_backはユーザーが直前にリクエストを送ったページに戻す
#     # fallback_location: デフォルトの設定
#   end

  # def create
  #   article = Article.find(params[:article_id])
  #   bookmark = article.bookmarks.build(user_id: current_user.id)
  #   if bookmark.save
  #     redirect_to request.referer
  #   else
  #     redirect_to request.referer
  #   end
  # end

  # def destroy
  #   article = current_user.articles.find(params[:article_id])
  #   bookmark = article.bookmarks.find_by(user_id: current_user.id)
  #   if bookmark.present?
  #     bookmark.destroy
  #     redirect_to request.referer
  #   else
  #     redirect_to request.referer
  #   end
  # end

  def create
    article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.new(article_id: article.id)
    @bookmark.save
    # redirect_back(fallback_location: root_path) #リダイレクト先を削除することでjavascriptリクエストとなり、createアクション実行後はcreate.js.erbファイルを探すようになる
  end

  def destroy
    article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.find_by(article_id: article.id)
    @bookmark.destroy
    # redirect_back(fallback_location: root_path)   #リダイレクト先を削除することでjavascriptリクエストとなり、destroyアクション実行後はdestroy.js.erbファイルを探すようになる
  end




  # def index
  # @bookmarks = current_customer.bookmarks.all
  # end
end