class UsersController < ApplicationController
  
    def show
      @user = User.find(params[:id]) #just trying to find the id
                                     #user the find method on the User model to retrieve the user from the data base
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(params[:user]) #not the final implementation
  if @user.save
      # Handle a successful save
    else
      render 'new'
    end
  end
end
# debugger #issues commands to figure out the state of the application
  #good practice to put degger close to the code you think might be causing the trouble
   #inspecting the state of the systedm using byebug for tracking down appliction errors