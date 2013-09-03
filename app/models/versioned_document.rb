# Notionally this represents a "versioned document" which is published
# according to the following model:
# * There is at most one published version.
# * There is at most one new version, which is the next version after the
#   published version, or, version 1 if it is the first version ever.
#
# Currently there is only one item of this model, which represents 
# the editing and publication of the user agreements (AKA Terms and Conditions).
class VersionedDocument < ActiveRecord::Base
  belongs_to :published_version, class_name: UserAgreement
  belongs_to :new_version, class_name: UserAgreement
  
  # Get the one record which manages publication of user agreements
  # (Make one if it doesn't yet exist.)
  def self.get_versioned_document
    versioned_document = VersionedDocument.all.first
    if !versioned_document
      versioned_document = VersionedDocument.create(published_version: nil, new_version: nil)
    end
    versioned_document
  end
end
