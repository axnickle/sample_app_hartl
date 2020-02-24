class User < ApplicationRecord
    #syntax means that the User class inherits from the ApplicationRecord class, 
    #which in turn inherits from ActiveRecord::Base, so that the User model 
    #automatically has all the functionality of the ActiveRecord::Base class.
    
    before_save { email.downcase! }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX }, #VALID_EMAIL_REGEX is a constant, indicated in ruby
                                                                #by a name starting with a capital letter
                    uniqueness: true
    has_secure_password
end

#presence: true argument is one-lement options hase; 
    #curly braces are optional when passing hashes as the final argument in a method
#validates is a method. An equivalent formation of this validates(:name, presence: true)
# alternate syntax: validates(:name, { presence: true, length: {maximum: 50} })