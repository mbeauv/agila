class CreateAccounts < ActiveRecord::Migration[7.1]
  enable_extension 'pgcrypto' unless extensions.include?('pgcrypto')
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
