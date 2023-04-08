class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  # poderia ser assim também: before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    current_page = (params[:page || 1]).to_i
    @articles = Article.order(created_At: :desc).page(current_page).per(5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
