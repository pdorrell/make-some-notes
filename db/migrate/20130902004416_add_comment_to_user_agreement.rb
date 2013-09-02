class AddCommentToUserAgreement < ActiveRecord::Migration
  def change
    add_column :user_agreements, :comment, :string
  end
end
