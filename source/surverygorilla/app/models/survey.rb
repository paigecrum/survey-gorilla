class Survey < ActiveRecord::Base
  validates :title, presence: true

  has_many :questions
  belongs_to :creator, class_name: :User
  has_many :user_surveys
  has_many :takers, class_name: :User, through: :user_surveys

end
