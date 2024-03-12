class AddAccountIdToProjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :projects, :account, null: false, foreign_key: true, type: :uuid
  end
end
