class UserResponse < ActiveRecord::Base
  belongs_to :response
  belongs_to :user
end
