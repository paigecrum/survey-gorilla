class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :choice_text
      t.integer :question_id

      t.timestamps
    end
  end
end
