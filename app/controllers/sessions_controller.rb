class SessionsController<ApplicationController
    def create
        user=User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id]=user.id
            flash[:notice]="Logged in Successfully"
            redirect_to user
        else
            flash.now[:alert]= "Invalid Email Id or Password"
            render 'new'
        end
    end
    def new
    end
    def destroy
        session[:user_id]=nil
        flash[:notice]= "Logged Out"
        redirect_to root_path
    end
end