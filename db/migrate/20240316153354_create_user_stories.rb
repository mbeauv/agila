class CreateUserStories < ActiveRecord::Migration[7.1]
  def change
    create_table :user_stories do |t|
      t.string :title
      t.text :description
      t.integer :estimate
      t.integer :status, null: false
      t.references :project, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end

    add_check_constraint :user_stories, "status IN (0, 1, 2, 3, 4)", name: "check_status"
  end
end
