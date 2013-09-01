class Note < ActiveRecord::Base
  belongs_to :user
  
  validates :user, presence: true
  validates :title, presence: true
  validates :text, presence: true
end
