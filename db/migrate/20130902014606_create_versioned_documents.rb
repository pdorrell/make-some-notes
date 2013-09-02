class CreateVersionedDocuments < ActiveRecord::Migration
  def change
    create_table :versioned_documents do |t|
      t.integer :published_version
      t.integer :new_version

      t.timestamps
    end
  end
end
