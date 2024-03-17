class CreateSprints < ActiveRecord::Migration[7.1]
  def change
    create_table :sprints do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.boolean :active
      t.references :project, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
