module UsersHelper
  
  #Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
  gravatar_id  = Digest::MD5::hexdigest(user.email.downcase) #standarization that'll ensure there won't be a failure do to case sensitivity, not a necessity
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"        #77fb241a0e1d7bfb216059d0965709c0"
  image_tag(gravatar_url, alt: user.name, class: "gravatar") #this is not a Ruby class, it's a css class
  end
end


#Digest::MD5::hexdigest(user.email) - assessing user.email, it's calling the MD5 Hexdigesting Method then interpolating the id -into the url,then putting image on the page
# def gravatar_for(user, options = { size: 80 }) - using keyword arguments in the gravatar_for helper
    #size         = options[:size]
# the above 2 lines is the same as line 4