class FixDatabaseColumn < ActiveRecord::Migration
  def change
    rename_column :versioned_documents, :published_version, :published_version_id
    rename_column :versioned_documents, :new_version, :new_version_id
  end
end
