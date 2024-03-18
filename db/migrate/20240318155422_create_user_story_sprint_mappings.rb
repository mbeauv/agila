class CreateUserStorySprintMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :user_story_sprint_mappings do |t|
      t.references :user_story, null: false, foreign_key: true
      t.references :sprint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
