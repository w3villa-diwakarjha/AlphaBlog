class UsersController<ApplicationController
    def new
        @user= User.new
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