class UsersController < ApplicationController
  
    def show
      @user = User.find(params[:id]) #just trying to find the id
                                     #user the find method on the User model to retrieve the user from the data base
    end
    
    def new
      @user = User.new
    end
    
    def create
      #@user = User.new(params[:user]) #not the final implementation; :user - set of information required to create new user, not always unique
      @user = User.new(user_params)
      if @user.save
        #Handle a successful save
        flash[:success] = "Welcome to the Sample App!" # flash gives it a KEY, which is [:success]
        redirect_to @user                             #flash tell rails this data should only persist for 1 request
      else
        render 'new'
      end
    end


  private

    def user_params 
      params.require(:user).permit(:name, :email, :password,     
                                    :password_confirmation) #strong parameter
    end
  end
# debugger #issues commands to figure out the state of the application
  #good practice to put degger close to the code you think might be causing the trouble
  #inspecting the state of the systedm using byebug for tracking down appliction errors