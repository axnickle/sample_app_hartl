class SessionsController < ApplicationController
  
  def new
  end
  
  def create
     user = User.find_by(email: params[:session][:email].downcase) #test for the incorrect password (not testing email)
      # user && user.authenticate(params[:session][:password])
     if user&.authenticate(params[:session][:password]) #same as line 9, but a condensed version
    
    # log the user in and redirect to the user's how page.
    log_in user #ready to complete the session create action by logging the user in and
    
    redirect_to user #redirecting to the user's profile page; same as user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right
      # flash.now dissappear as soon as there is an additional request
      # create an error message.
      render 'new'
    end
end

  def destroy
    log_out
    redirect_to root_url
  end
end

# && (logical and) to determine if the resulting user is valid
# now this file is complete, the form on sessions/new.html.erb should now be working
# Using the “safe navigation” operator &. to simplify the login code.