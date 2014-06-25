class CreateUserSurveys < ActiveRecord::Migration
  def change
    create_table :user_surveys do |t|
      t.integer :survey_id
      t.integer :taker_id

      t.timestamps
    end
  end
end
