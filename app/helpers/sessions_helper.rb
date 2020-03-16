module SessionsHelper
  
  # log in the given user.
  def log_in(user)
    session[:user_id] = user.id #sessions cookie automatcially encrypts and cookies in the browser
  end
  
  # remembers a user in a persistent session.
   def remember(user)
      user.remember
      cookies.permanent.encrypted[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
   end
  
  # returns the user corresponding to the remember token cookie. 
   def current_user
      if (user_id = session[:user_id])
       @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.encrypted[:user_id])
        user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
      end
   end    
  
  # returns true if the user is logged in. false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # fogets a persistent session
  def forget(user)
     user.forget
     cookies.delete(:user_id)
     cookies.delete(:remember_token)
  end
     
  # logs out the current user.
  def log_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
  end
end

# line 5: sessions create temporary cookie w/ encrypted id
# not the same as cookies method