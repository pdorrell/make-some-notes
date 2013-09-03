# "User Agreement" is a synonym for "Terms and Conditions" (which avoids being plural in the singular).
class UserAgreement < ActiveRecord::Base
  validates :comment, :text, presence: true
  
  # A user agreement can be published if it hasn't yet been published.
  def can_publish?
    !published_at
  end
  
  # A user agreement can be edited if it hasn't yet been published.
  def can_edit?
    !published_at
  end
  
  # Publish a user agreement
  def publish
    # Make sure it is not already published
    if published_at
      raise Exception.new("Cannot publish User Agreement that is already published");
    end
    published_datetime = Time.now # It's being published now
    transaction do
      versioned_document = VersionedDocument.get_versioned_document
      previous_agreement = versioned_document.published_version
      
      puts "published_datetime = #{published_datetime.inspect}"
      
      # Any existing published version will be superceded
      if previous_agreement
        previous_agreement.superceded_at = published_datetime
        previous_agreement.save
        puts "Saved previous_agreement"
      end
      self.published_at = published_datetime
      puts "Saving self = #{self.inspect}"
      save
      # Record this user agreement as being the published version
      versioned_document.published_version = self
      # This user agreement is no longer the new version (which it presumably was)
      versioned_document.new_version = nil
      puts "Saving versioned_document = #{versioned_document.inspect}"
      versioned_document.save
      puts "All saved."
    end
  end
  
  # Does a new (unpublished) user agreement exist?
  def self.new_version_exists?
    versioned_document = VersionedDocument.get_versioned_document
    versioned_document && versioned_document.new_version != nil
  end
  
  # Create a new version. Either it's the first version ever, created with
  # default title and text, or it's a copy of the current published version, 
  # with the comment annotated to say so.
  def self.create_new_version
    versioned_document = VersionedDocument.get_versioned_document
    if versioned_document.new_version != nil
      raise Exception.new("Cannot create new version: one already exists")
    end
    if versioned_document.published_version == nil
      previous_version = nil
      new_version_number = 1
    else
      previous_version = versioned_document.published_version
      new_version_number = previous_version.version+1
    end
    user_agreement = UserAgreement.new(version: new_version_number)
    if previous_version
      user_agreement.comment = "[New version, copied from version #{previous_version.version}] " + 
        previous_version.comment
      user_agreement.text = previous_version.text
    else
      user_agreement.comment = "[First version]"
      user_agreement.text = "(Put agreement text here.)"
    end
    user_agreement.save
    versioned_document.new_version = user_agreement
    versioned_document.save
    UserAgreement.find(user_agreement.id)
  end
  
  # Get the current published user agreement (if there is one)
  def self.get_current
    versioned_document = VersionedDocument.get_versioned_document
    versioned_document.published_version
  end
  
end
