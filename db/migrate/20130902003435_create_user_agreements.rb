class CreateUserAgreements < ActiveRecord::Migration
  def change
    create_table :user_agreements do |t|
      t.string :text
      t.datetime :published_at

      t.timestamps
    end
  end
end
