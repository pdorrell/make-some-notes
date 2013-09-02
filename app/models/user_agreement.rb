class UserAgreement < ActiveRecord::Base
  validates :comment, :text, presence: true
  
  def can_publish?
    !published_at
  end
  
  def can_edit?
    !published_at
  end
  
end
