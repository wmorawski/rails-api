class ArticlesController < ApplicationController
  def index
    render json: serializer.new(Article.recent)
  end

  def show
    render json: Article.find(params[:id])
  end

  def serializer
    ArticleSerializer
  end
end
