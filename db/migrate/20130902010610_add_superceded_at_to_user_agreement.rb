class AddSupercededAtToUserAgreement < ActiveRecord::Migration
  def change
    add_column :user_agreements, :superceded_at, :datetime
  end
end
