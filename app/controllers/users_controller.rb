class UsersController<ApplicationController
    def new
        @user= User.new
    end
    def show
        @user= User.find(params[:id])
        @articles=@user.articles
    end
    def update
        @user= User.find(params[:id])
        if @user.update(user_params)
            flash[:notice]= "Your Account was Successfully Updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
    def edit
        @user=User.find(params[:id])
    end

    def index
        @user=User.all
    end
    def create 
        @user=User.new(user_params)
        if @user.save
            flash[:notice]="Welcomr to the Alpha Blog #{@user.username}, You have successfully signup"
            redirect_to articles_path
        else
            render  'new'
        end
    end
    def user_params
        params.require(:user).permit(:username,:email,:password)
    end
end