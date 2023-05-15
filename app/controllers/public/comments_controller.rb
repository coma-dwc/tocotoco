class Public::CommentsController < ApplicationController

  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = @article.id
    @comment.save
  end

  def destroy
    @user = current_user
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
  end


private

def comment_params
  params.require(:comment).permit(:body)
end

end
