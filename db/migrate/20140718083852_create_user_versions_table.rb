class CreateUserVersionsTable < ActiveRecord::Migration
  def change
    create_table :user_versions do |t|
      t.references :user
      t.string :user_type
      t.references :version

      t.timestamps
    end
  end
end
