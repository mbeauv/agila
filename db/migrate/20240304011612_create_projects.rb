class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto' unless extensions.include?('pgcrypto')

    create_table :projects, id: :uuid do |t|
      t.string :name, null: false, unique: true
      t.text :description
      t.date :start_date, null: false
      t.date :end_date
      t.integer :status, null: false

      t.timestamps
    end

    add_check_constraint :projects, "status IN (0, 1, 2, 3, 4)", name: "check_status"
  end
end