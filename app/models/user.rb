class User < ActiveRecord::Base

	extend FriendlyId
    friendly_id :name, use: :slugged

	include BCrypt
	has_many :answers, dependent: :destroy
	has_many :questions, dependent: :destroy
	has_many :question_votes, dependent: :destroy
	validates_presence_of :email 
	validates_presence_of :username
	validates_presence_of :password
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 	
	validates :email, uniqueness: true # { message: "This email address has been taken." }
	validates :username, uniqueness: true



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

	  def has_voted(question)
	  	question_votes.find_by(question_id: question.id)
	  end
end
