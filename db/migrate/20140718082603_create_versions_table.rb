class CreateVersionsTable < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :package
      t.string :name

      t.timestamps
    end
  end
end
