class UserSurvey < ActiveRecord::Base
  belongs_to :survey
  belongs_to :taker, class_name: :user
end

