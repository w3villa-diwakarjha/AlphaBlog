class ArticlesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def show   
    end

    def index
        @articles=Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article=Article.new
    end

    def edit
        
    end

    def create
        @article= Article.new(article_params)
        @article.user=current_user
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

    def require_same_user
        byebug
        if current_user != @article.user && !current_user.admin?
            flash[:alert]="You can only edit or Delete own Article"
            redirect_to @article
        end
    end
end