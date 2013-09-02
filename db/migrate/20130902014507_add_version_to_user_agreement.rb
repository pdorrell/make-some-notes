class AddVersionToUserAgreement < ActiveRecord::Migration
  def change
    add_column :user_agreements, :version, :integer
  end
end
