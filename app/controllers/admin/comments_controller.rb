class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  # def create
  #   @article = Article.find(params[:article_id])
  #   @comment = current_user.article_comments.new(article_comment_params)
  #   @comment.article_id = @article.id
  #   @comment.save
  # end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @article = Article.find(params[:article_id])
  end
  # def destroy
  #   @comment = Comment.find(params[:id])
  #   if current_admin || @comment.user == current_user
  #     @comment.destroy
  #     redirect_to @comment.article, notice: 'コメントを削除しました'
  #   else
  #     redirect_to root_path, alert: '権限がありません'
  #   end
  # end
  # private

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :body)
  end

end
