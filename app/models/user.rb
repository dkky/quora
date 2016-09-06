class User < ActiveRecord::Base
	include BCrypt
	has_many :answers
	has_many :questions
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email, uniqueness: true

	# has_secure_password

	  def password
    	@password ||= Password.new(password_digest)
  	  end

  	  def password=(new_password)
    	@password = Password.create(new_password)
        self.password_digest = @password
  	  end

  	  def self.authenticate(email, password)
  	  	user = User.find_by_email(email)
  	  	if user && user.password == password
  	  		return user
  	  	else
  	  		return false
	  	end
	  end
end
