class VersionedDocument < ActiveRecord::Base
  has_one :published_version, class_name: UserAgreement
  has_one :new_version, class_name: UserAgreement
  
  def self.get_versioned_document
    versioned_document = VersionedDocument.all.first
    if !versioned_document
      versioned_document = VersionedDocument.create(published_version: nil, new_version: nil)
    end
    versioned_document
  end
end
