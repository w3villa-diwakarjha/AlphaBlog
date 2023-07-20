class UsersController<ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def new
        @user= User.new
    end
    def show
        @articles=@user.articles.paginate(page: params[:page], per_page: 5)
    end
    def update
        if @user.update(user_params)
            flash[:notice]= "Your Account was Successfully Updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
    def edit
    end

    def index
        @user=User.paginate(page: params[:page], per_page: 5)
    end

    def destroy
        @user.destroy
        session[:user_id]=nil if @user==current_user
        flash[:notice]= "Account has been successfully Deleted"
        redirect_to root_path
    end

    def create 
        @user=User.new(user_params)
        if @user.save
            session[:user_id]= @user.id
            flash[:notice]="Welcomr to the Alpha Blog #{@user.username}, You have successfully signup"
            redirect_to articles_path
        else
            render  'new'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username,:email,:password)
    end

    def set_user
        @user= User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert]="You can only edit your own Account"
            redirect_to @user
        end
    end


end