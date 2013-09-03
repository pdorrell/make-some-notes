module UserAgreementsHelper
  # Does a new (unpublished) User Agreement exist?
  def new_user_agreement_version_exists?
    UserAgreement.new_version_exists?
  end
end
