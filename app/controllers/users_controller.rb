class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update]
   before_action :correct_user,   only: [:edit, :update]
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
        log_in @user #logging in the user upon sign up (rather than having to sign up then logging right away)
        #Handle a successful save
        flash[:success] = "Welcome to the Sample App!" # flash gives it a KEY, which is [:success]
        redirect_to @user                             #flash tell rails this data should only persist for 1 request
      else
        render 'new'
      end
    end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params) #(user_params- strong params
    # handles a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

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