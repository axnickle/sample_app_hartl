class SessionsController < ApplicationController
  
  def new
  end
  
  def create #A template for using an instance variable in the create action.
    user = User.find_by(email: params[:session][:email].downcase) #test for the incorrect password (not testing email)
    if user && user.authenticate(params[:session][:password])
         if user.activated?
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or user
         else
            message  = "Account not activated. "
            message += "Check your email for the activation link."
        flash[:warning] = message
            redirect_to root_url
         end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

# && (logical and) to determine if the resulting user is valid
# now this file is complete, the form on sessions/new.html.erb should now be working
# Using the “safe navigation” operator &. to simplify the login code.