module SessionsHelper
  
  # log in the given user.
  def log_in(user)
    session[:user_id] = user.id #create temporary cookie w/ encrypted id
  end
end
