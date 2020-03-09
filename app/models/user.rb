class User < ApplicationRecord
    #syntax means that the User class inherits from the ApplicationRecord class, 
    #which in turn inherits from ActiveRecord::Base, so that the User model 
    #automatically has all the functionality of the ActiveRecord::Base class.
    
    before_save { self.email.downcase! }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, #whole email has to be less than 255
                    format:     { with: VALID_EMAIL_REGEX }, #VALID_EMAIL_REGEX is a constant, indicated in ruby
                                                                #by a name starting with a capital letter
                    uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 5 }
    
    # returns the hash digest of the given string
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost) # string is the string to be hashed
    end                                                 # cost is the cost parameter that determines the computational cost to calculate the hash
end

#presence: true argument is one-lement options hase; 
    #curly braces are optional when passing hashes as the final argument in a method
#validates is a method. An equivalent formation of this validates(:name, presence: true)
# alternate syntax: validates(:name, { presence: true, length: {maximum: 50} })

#test 