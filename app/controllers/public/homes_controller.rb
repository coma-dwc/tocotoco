class Public::HomesController < ApplicationController

  def top
    @articles = Article
      .limit(3)
      .order(created_at: :desc)
  end

  def about
  end
end
