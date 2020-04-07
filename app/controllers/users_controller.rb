class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
   before_action :correct_user,   only: [:edit, :update]
   before_action :admin_user,     only: :destroy #a before filter restricting the destroy action to admins
   #commenting out the before filter to test the security model
   #both 'edit' and 'update' actions allow users to modify records in the database,
    #so for security it's important to protect them both
   #it's much easier to test the protection of the 'edit' action, because the 'update'
    #action gets hit by PATCH requests, which can't be issued by browsers.
    #it's possible to issue PATCH directly requests at the command line using something
    #like CURL, but it's much more robust to build them into automated tests
    
    def index
        @users = User.paginate(page: params[:page])
    end
    
    def show
      @user = User.find(params[:id]) #just trying to find the id
                                     #user the find method on the User model to retrieve the user from the data base
    end
    
    def new
      @user = User.new
    end
    
    def create
      #@user = User.new(params[:user]) #not the final implementation; :user - set of information required to create new user, not always unique
      @user = User.new(user_params) #will find users based on params
      if @user.save
       @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        render 'new'
      end
    end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy #adding a working 'destroy' admin
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    #will only be used internally by the Users controller and need not be exposed to external users via the web
      #we’ll make it private using Ruby’s private keyword
    def user_params 
      params.require(:user).permit(:name, :email, :password,     
                                    :password_confirmation) #strong parameter
    end
    
    # Before filters
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      #correct_user before filter
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
# debugger #issues commands to figure out the state of the application
  #good practice to put degger close to the code you think might be causing the trouble
  #inspecting the state of the systedm using byebug for tracking down appliction errors
   
# @user = User.new(user_params)
  #will find users based on params - params come from /users/1/edit