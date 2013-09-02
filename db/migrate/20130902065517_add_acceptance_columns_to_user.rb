class AddAcceptanceColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :latest_terms_version, :integer
    add_column :users, :accepted_terms_version, :integer
  end
end
