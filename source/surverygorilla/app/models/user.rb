# require 'bcrypt' # required in environment.rb instead

class User < ActiveRecord::Base
  validates :email, :password_hash, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  has_many :created_surveys, class_name: :Survey, foreign_key: :creator_id
  has_many :user_surveys, foreign_key: :taker_id
  has_many :taken_surveys, through: :user_surveys, source: :survey
  has_many :user_responses
  has_many :responses, through: :user_responses

	# users.password_hash in the database is a :string
	include BCrypt

	def password
	  @password ||= Password.new(password_hash)
	end

	def password=(new_password)
	  @password = Password.create(new_password)
	  self.password_hash = @password
	end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end
end



# SELECT * FROM created_surveys WHERE created_surveys.user_id = user.id
# SELECT * FROM surveys WHERE surveys.user_id = user.id
# SELECT * FROM surveys WHERE surveys.creator_id = user.id

# SQL?
# user = User.last
# SELECT * FROM created_surveys WHERE created_surveys.user_id = user.id

#  has_many :created_surveys, foreign_key: :creator_id
# SELECT * FROM created_surveys WHERE created_surveys.creator_id = user.id

# has_many :created_surveys, foreign_key: :creator_id, class_name: :survey
# SELECT * FROM surveys FROM surveys.creator_id = user.id

# DESIRED SQL
# SELECT * FROM surveys WHERE surveys.creator_id = user.id



#SQL
#  has_many :taken_surveys, through: :user_surveys
# SELECT * FROM surveys JOIN user_surveys ON user_surveys.survey_id = surveys.id
# WHERE user_surveys.taker_id = user.id


