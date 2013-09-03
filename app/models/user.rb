class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  has_many :notes
  
  # Determine latest version of Terms and Conditions when a new user is registered
  after_create :set_latest_terms_version
  
  # Determine latest version of Terms and Conditions each time user logs in
  def after_database_authentication
    set_latest_terms_version
  end

  # Determine which version of the Terms and Conditions is the published version
  # when either a new user is registered, or otherwise each time when a user logs in.
  def set_latest_terms_version
    current_terms = UserAgreement.get_current
    if current_terms && current_terms.version != latest_terms_version
      puts "Setting latest terms version for user #{email} to #{current_terms.version}"
      self.latest_terms_version = current_terms.version
      save
    end
  end
  
  # Has this user accepted the latest Terms and Conditions?
  def has_accepted_latest_terms?
    latest_terms_version == accepted_terms_version
  end
  
  # Update model to state that the user has accepted the given version of the Terms and Conditions.
  def accept_terms_and_conditions(user_agreement)
    self.accepted_terms_version = user_agreement.version
    save
  end

end
