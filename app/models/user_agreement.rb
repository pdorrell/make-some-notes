class UserAgreement < ActiveRecord::Base
  validates :comment, :text, presence: true
end
