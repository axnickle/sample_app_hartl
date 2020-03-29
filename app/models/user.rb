class User < ApplicationRecord
    #syntax means that the User class inherits from the ApplicationRecord class, 
    #which in turn inherits from ActiveRecord::Base, so that the User model 
    #automatically has all the functionality of the ActiveRecord::Base class.
    
    #adding a remember methond  - lines 8, 33, 34
        #create a valid token and associated digest by first making a new remember token using User.new_token, then updating the remember digest with the result of applying User.digest
    
    attr_accessor :remember_token #create an accessible attribute 
    before_save { self.email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, #whole email has to be less than 255
                    format:     { with: VALID_EMAIL_REGEX }, #VALID_EMAIL_REGEX is a constant, indicated in ruby
                                                                #by a name starting with a capital letter
                    uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    # returns the hash digest of the given string
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost) # string is the string to be hashed
    end                                                 # cost is the cost parameter that determines the computational cost to calculate the hash

    # Returns a random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # remembers a user in the database for user in persistent sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token)) #update the remember digest
    end                                                             #this method bypasses the validations...necessary...b/c
                                                                    #we don't have user's pw or confirmation
    
    # Return true if the given token matches the digest 
     def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token) #remember_oken is a variable local to the method
     end                                                               #NOT the same as the attr_accessor :remember_token in user.rb
    
    # forgets a user
     def forget
       update_attribute(:remember_digest, nil)
     end
end
        

#presence: true argument is one-lement options hase; 
    #curly braces are optional when passing hashes as the final argument in a method
#validates is a method. An equivalent formation of this validates(:name, presence: true)
# alternate syntax: validates(:name, { presence: true, length: {maximum: 50} })
#test 