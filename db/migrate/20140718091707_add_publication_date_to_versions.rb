class AddPublicationDateToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :publication_date, :datetime
  end
end
