class Public::CommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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

def ensure_correct_user
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      redirect_to article_path(@comment.article)
    end
end


end
