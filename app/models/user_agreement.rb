class UserAgreement < ActiveRecord::Base
  validates :comment, :text, presence: true
  
  def can_publish?
    !published_at
  end
  
  def can_edit?
    !published_at
  end
  
  def publish
    if published_at
      raise Exception.new("Cannot publish User Agreement that is already published");
    end
    published_datetime = Time.now
    transaction do
      versioned_document = VersionedDocument.get_versioned_document
      previous_agreement = versioned_document.published_version
      
      puts "published_datetime = #{published_datetime.inspect}"
      
      if previous_agreement
        previous_agreement.superceded_at = published_datetime
        previous_agreement.save
        puts "Saved previous_agreement"
      end
      self.published_at = published_datetime
      puts "Saving self = #{self.inspect}"
      save
      versioned_document.published_version = self
      versioned_document.new_version = nil
      puts "Saving versioned_document = #{versioned_document.inspect}"
      versioned_document.save
      puts "All saved."
    end
  end
  
  def self.new_version_exists?
    versioned_document = VersionedDocument.get_versioned_document
    versioned_document && versioned_document.new_version != nil
  end
  
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
  
  def self.get_current
    versioned_document = VersionedDocument.get_versioned_document
    versioned_document.published_version
  end
  
end
