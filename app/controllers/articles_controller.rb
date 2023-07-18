class ArticlesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
    def show
        
    end
    def index
        @articles=Article.all
    end

    def new
        @article=Article.new
    end

    def edit
        
    end

    def create
        @article= Article.new(article_params)
        @article.user=User.first
        if @article.save
            flash[:notice]= "Article was Successfully Created"
            redirect_to @article
        else
            render 'new'
        end
    end
    def update
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice]="Article is updated Successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_message
        @article= Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end
end