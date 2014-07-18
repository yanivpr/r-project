class CreatePackagesTable < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.datetime :publication_date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
