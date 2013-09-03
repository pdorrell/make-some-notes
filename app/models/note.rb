# A note that a user can create, and which belongs to that user.
# Each note has a title and text.
# Notes are displayed (escaped) in <pre> tags, so they are 
# effectively plain text with line endings.
  
class Note < ActiveRecord::Base
  belongs_to :user
  
  validates :user, presence: true
  validates :title, presence: true
  validates :text, presence: true
end
