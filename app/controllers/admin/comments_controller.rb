class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :body)
  end

end
