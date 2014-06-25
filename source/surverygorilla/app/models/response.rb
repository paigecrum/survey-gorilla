class Response < ActiveRecord::Base
  validates :choice_text, presence: true

  belongs_to :question
  has_many :user_responses
  has_many :takers, through: :user_responses, source: :user

end
